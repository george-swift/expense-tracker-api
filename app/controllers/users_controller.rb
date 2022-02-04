class UsersController < ApplicationController
  skip_before_action :authorized, except: :update

  def index
    @users = User.all
    render json: { users: @users.as_json }
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: { user: @user.as_json, lists: @user.lists, expenses: @user.expenses }
    else
      render json: { error: 'User not found' }, status: :internal_server_error
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @token = encode_token(@user)
      render json: { authenticated: true, user: @user.as_json, token: @token }, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if current_user.update(user_params)
      render json: { user: current_user.as_json, message: 'Profile successfully updated' }, status: :ok
    else
      render json: { error: 'Could not update profile' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :email, :password, :password_confirmation)
  end
end
