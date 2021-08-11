require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:users) { create_list(:user, 3) }
  let(:user_id) { users.first.id }

  describe 'GET /users' do
    before { get '/users' }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json['users'].size).to eq(3)
    end
  end

  describe 'GET /users/:id' do
    before { get "/users/#{user_id}" }

    context 'when a user does not exist in database' do
      let(:user_id) { 0 }

      it 'returns a message that user cannot be found' do
        expect(json['message']).to match(/Couldn't find User with 'id'=0/)
      end
    end

    context 'when a user exists in database' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['user']['id']).to eq(user_id)
      end
    end
  end

  describe 'POST /users' do
    let(:valid_attributes) do
      {
        user: { username: 'Foobar', email: 'test@example.com', password: 'foobar', password_confirmation: 'foobar' }
      }
    end

    let(:invalid_attributes) do
      {
        user: { username: 'Foobar', email: 'testexample,com', password: 'foobar', password_confirmation: 'foobar' }
      }
    end

    context 'when the request is invalid' do
      before { post '/users', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation error message' do
        expect(!session[:user_id].nil?).to be(false)
        expect(json['error'].to_s).to match('Email is invalid')
      end
    end

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(:created)
      end

      it 'creates a new user' do
        expect(json['user']['username']).to eq('Foobar')
        expect(!session[:user_id].nil?).to be(true)
      end
    end
  end

  describe 'PUT /users' do
    let(:user) { users.first }

    let(:valid_attributes) { { user: { username: 'Kent' } } }

    let(:invalid_attributes) { { user: { username: '' } } }

    context 'when the request is invalid' do
      before { put "/users/#{user.id}", params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        expect(json['error']).to match(/Could not update profile/)
      end
    end

    context 'when the request is valid' do
      before { put "/users/#{user.id}", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates a user in the database' do
        expect(json['message']).to match(/Profile successfully updated/)
      end
    end
  end
end
