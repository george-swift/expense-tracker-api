class SessionsController < ApplicationController
  skip_before_action :authorized, only: :create

  def create
    @user = User.find_by(username: session_params[:username])
    if @user&.authenticate(session_params[:password])
      @token = encode_token(@user)
      render json: { authenticated: true, user: @user.as_json, token: @token }, status: :created
    else
      render json: { error: 'Invalid username/password combination' }, status: :unauthorized
    end
  end

  def destroy
    log_out
    render json: { authenticated: false }, status: :ok
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
