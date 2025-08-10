class SessionsController < ApplicationController
  # Skip auth check for login and session status
  skip_before_action :authorize_request, only: [:create, :show]

  # POST /login 
  def create
    #extract email and password from the entered params sent fron the login form on the frontend
    email = login_params[:email]
    password = login_params[:password]

    #find the user by their email
    user = User.find_by(email: email)

    #if user exists and password correct - uses has_secure_password - in user.rb
    if user&.authenticate(password)
      session[:user_id] = user.id  #store the user id in the session cookie to keep them logged in
      #respond with user data only showing safe fields
      render json: user.slice(:id, :username, :email, :admin), status: :ok
    else
      #if authentication fails, show error
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end


  #DELETE /logout
  def destroy
    #remove user_id from the session to log them out
    session.delete(:user_id)
    #respond with no content (204)
    head :no_content
  end

  #GET /me - check current usre
  def show
    #use current_user helper method from application_controller to check session
    if current_user 
      #if logged in, return basic user info
      render json: current_user.slice(:id, :username, :email, :admin), status: :ok
    else
      #if not logged in, return error
      render json: { error: "Not logged in" }, status: :unauthorized
    end
  end

  private

  #use strong parameters to permit only email and password from the incoming request
  def login_params
    params.permit(:email, :password)
  end
end

