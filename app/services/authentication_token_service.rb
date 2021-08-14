class AuthenticationTokenService
  HMAC_SECRET = ENV['EXPENSE_TRACKER_SECRET_KEY']
  ALGORITHM_TYPE = 'HS256'.freeze

  def self.encode(user_id)
    payload = { user_id: user_id }

    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.decode(token)
    decoded_token = JWT.decode token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }
    decoded_token.first['user_id']
  end
end
