require 'rails_helper'

RSpec.describe 'Lists', type: :request do
  let!(:user) { create(:user) }
  let!(:lists) { create_list(:list, 3, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { lists.first.id }

  describe 'GET /users/:user_id/lists' do
    before { get "/users/#{user_id}/lists" }

    context 'when user does not exist in database' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to match(/Couldn't find User with 'id'=0/)
      end
    end

    context 'when user exists in database' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all lists for given user' do
        expect(json.size).to eq(3)
      end
    end
  end

  describe 'GET /lists/:id' do
    before { get "/lists/#{id}" }

    context 'when list does not exist in database' do
      let(:id) { 0 }
      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to match(/Couldn't find List with 'id'=0/)
      end
    end

    context 'when list exists in database' do
      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
        expect(json['id']).to eq(id)
      end
    end
  end

  describe 'POST /users/:user_id/lists' do
    let(:valid_attributes) { { list: { name: 'General expense', user_id: user_id } } }

    let(:invalid_attributes) { { list: { name: '', user_id: user_id } } }

    context 'when the request is invalid' do
      before { post "/users/#{user_id}/lists", params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a validation error message' do
        expect(json['error']).to match('Unable to create list')
      end
    end

    context 'when the request is valid' do
      before { post "/users/#{user_id}/lists", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new list' do
        expect(json['name']).to match('General expense')
      end
    end
  end

  describe 'PUT /lists/:id' do
    let(:valid_attributes) { { list: { name: 'Special expense' } } }

    before { put "/lists/#{id}", params: valid_attributes }

    context 'when the list does not exist in database' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find List with 'id'=0/)
      end
    end

    context 'when the list exists in database' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the list' do
        expect(List.find(id).name).to match(/Special/)
      end
    end
  end

  describe 'DELETE /lists/:id' do
    before { delete "/lists/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    before { get "/users/#{user_id}/lists" }

    it 'decreases the count of lists in the database' do
      expect(json.size).to eq(2)
      expect(json[0]['id']).not_to eq(id)
    end
  end
end
