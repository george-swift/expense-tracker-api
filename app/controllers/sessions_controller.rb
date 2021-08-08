class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: session_params[:username])
    if @user&.authenticate(session_params[:password])
      log_in @user
      render json: { signed_in: true, user: current_user }
    else
      render json: { error: 'Invalid username/password combination' }, status: :unauthorized
    end
  end

  def destroy
    log_out if logged_in?
    render json: { signed_out: true }, status: :ok
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
