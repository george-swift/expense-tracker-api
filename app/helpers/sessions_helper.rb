module SessionsHelper
  def encode_token(user)
    AuthenticationTokenService.encode(user.id)
  end

  def authentication_id
    token, _options = token_and_options(request)
    AuthenticationTokenService.decode(token)
  end

  def current_user
    @current_user ||= User.find_by(id: authentication_id)
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    reset_session
    @current_user = nil
  end
end
