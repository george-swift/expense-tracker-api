class ApplicationController < ActionController::API
  include ::ActionController::Cookies
  include SessionsHelper
  include Rescue
end
