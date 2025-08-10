class UsersController < ApplicationController
  #authorize_request and authorize_admin! both defined in application_controller
  #allow anyone to create a new user - sign up - but restrict other actions
  skip_before_action :authorize_request, only: [:create]
  #only allow admins to access index of all users, reactivate and delete user
  before_action :authorize_admin!, only: [:index, :destroy, :reactivate]


  #POST /users - register a new user and log them in
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id  #save user ID in session cookie to log them in
      render json: { user: user }, status: :created
    else
      #if validation fail, return error msg
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #PATCH /me - user can update their own info - or PATCH /users/:id - admin only can update others
  def update
    #if current user is admin and id param is given, update that user
    #otherwise update current user’s own info
    target_user = current_user.admin? && params[:id] ? User.find(params[:id]) : current_user

    if target_user.update(user_params)
      #return only safe user info on success
      render json: target_user.slice(:id, :username, :email, :admin), status: :ok
    else
      #return errors if update fails
      render json: { errors: target_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #DELETE /users/:id admin only can hard delete users via DELETE /users/:id
  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content   #return 204 no content on success
  end

  #SOFT DELETE - just flags the user as not active, users can deactivate themselves, admins can deactivate anyone
  def deactivate
    user = current_user.admin? ? User.find(params[:id]) : current_user

    #soft_delete defined in user.rb
    if user.soft_delete
      render json: { message: "User deactivated" }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #REACTIVATE admin only can switch user back to active
  def reactivate
    user = User.find(params[:id])
    if user.update(active: true)
      render json: { message: "User reactivated" }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  
  # GET /me - show current logged-in user info
  def show
    render json: current_user.slice(:id, :username, :email, :admin)
  end


  #INDEX admin only - list all users
  def index
      users = User.all
      #return only selected user info to avoid sending sensitive data
      render json: users.select(:id, :username, :email, :admin, :active)
  end


  private

  #strong parameters - only allow these fields from user input
  def user_params
    #only allow these attributes to be submitted via JSON
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
  