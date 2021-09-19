require 'rails_helper'

describe AuthenticationTokenService do
  let(:token) { described_class.encode(3) }

  describe '.encode' do
    it 'returns an authentication token' do
      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE }
      )

      expect(decoded_token).to eq(
        [
          { 'user_id' => 3 },
          { 'alg' => 'HS256' }
        ]
      )
    end
  end
end
