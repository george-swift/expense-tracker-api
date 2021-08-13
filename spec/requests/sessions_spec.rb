require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create(:user) }
  let(:token) { AuthenticationTokenService.encode(user.id) }

  describe 'POST /sessions' do
    it 'authenticates the client' do
      post '/sessions',
           params: { session: { username: user.username, password: user.password } },
           headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:created)
    end

    it 'returns error when password is incorrect' do
      post '/sessions', params: { session: { username: user.username, password: 'incorrect' } }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
