class ApplicationController < ActionController::Base
  #allow for reading/writing cookies (used for sessions)
  include ActionController::Cookies

  #disable CSRF protection to keep it simple, need to enable before deploying
  skip_before_action :verify_authenticity_token

  #to run before every action in controllers that inherit from this,
  #to check if user is logged in thereby protecting routes except login/registration
  before_action :authorize_request

  #look for current logged-in user from the request's sessoin cookie, if it exists, load the matching user || only look up user once per request
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])  
  end
  
    #return true if logged in, false if not
    def logged_in?
      !!current_user  #makes current_user a boolean
    end

  private
  #to check user is logged in
  def authorize_request
    render json: { error: "Not authorized" }, status: :unauthorized unless logged_in?
  end
  
  #to use throughout app to check for admin status when needed
  def authorize_admin!
    unless current_user&.admin?
      render json: { error: "Admin access required" }, status: :forbidden
    end
  end
end
