class ApplicationController < ActionController::API
  include ::ActionController::HttpAuthentication::Token
  include ::ActionController::Cookies
  include SessionsHelper
  include Rescue

  before_action :authorized

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
