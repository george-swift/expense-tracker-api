class UsersController < ApplicationController
  def index
    @users = User.all
    render json: { users: @users }
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: { user: @user, expenses: @user.expenses }
    else
      render json: { error: 'User not found' }, status: :internal_server_error
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      render json: { user: current_user }, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { user: @user, message: 'Profile successfully updated' }, status: :ok
    else
      render json: { error: 'Could not update profile' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
