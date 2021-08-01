class UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: { users: @users }
    else
      render json: { error: 'No users found' }, status: :internal_server_error
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: { user: @user }
    else
      render json: { error: 'User not found' }, status: :internal_server_error
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      render json: { user: @user }, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :internal_server_error
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { message: 'Profile successfully updated' }, status: :ok
    else
      render json: { error: 'Could not update profile' }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
