module Rescue
  extend ActiveSupport::Concern

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end
end
