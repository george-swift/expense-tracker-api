require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  let!(:users) { create_list(:user, 2) }

  let!(:list_one) { create(:list, user_id: users.first.id) }
  let(:list_one_id) { list_one.id }

  let!(:list_two) { create(:list, user_id: users.second.id) }
  let(:list_two_id) { list_two.id }

  let!(:first_user_expenses) { create_list(:expense, 2, list_id: list_one.id) }
  let!(:second_user_expenses) { create_list(:expense, 5, list_id: list_two.id) }

  let(:expense_one_id) { second_user_expenses.first.id }
  let(:expense_two_id) { first_user_expenses.last.id }

  describe 'GET /lists/:list_id/expenses' do
    before { get "/lists/#{list_one_id}/expenses" }

    context 'when a list of expenses does not exist in database' do
      let(:list_one_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to match(/Couldn't find List with 'id'=0/)
      end
    end

    context 'when a list of expenses exists in database' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it "returns all expenses in the first user's list" do
        expect(json.size).to eq(2)
        expect(users.first.expenses.size).to eq(json.size)
      end

      it "returns all expenses in the second user's list" do
        get "/lists/#{list_two_id}/expenses"
        expect(json.size).to eq(5)
        expect(users.second.expenses.size).to eq(json.size)
      end
    end
  end

  describe 'GET /expenses/:id' do
    before { get "/expenses/#{expense_one_id}" }

    context 'when an expense does not exist in database' do
      let(:expense_one_id) { 0 }
      it 'should return status code 404' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to match(/Couldn't find Expense with 'id'=0/)
      end
    end

    context 'when an expense exists in database' do
      it 'should return status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it "should return an expense in a given user's list" do
        expect(json['id']).to eq(users.second.expenses.find(expense_one_id).id)

        get "/expenses/#{expense_two_id}"

        expect(json['id']).to eq(users.first.expenses.find(expense_two_id).id)
      end
    end
  end

  describe 'POST /lists/:list_id/expenses' do
    let(:valid_attributes) { { expense: { title: 'Dinner', amount: 20, date: '2021-07-26', list_id: list_one_id } } }

    let(:invalid_attributes) { { expense: { title: '', amount: 20, date: '', list_id: list_one_id } } }

    context 'when the request is invalid' do
      before { post "/lists/#{list_one_id}/expenses", params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a validation error message' do
        expect(users.first.expenses.size).to eq(2)
        expect(json['error']).to match('Unable to create expense')
      end
    end

    context 'when the request is valid' do
      before { post "/lists/#{list_one_id}/expenses", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new expense' do
        expect(json['title']).to match(/Dinner/)
        expect(users.first.expenses.size).to eq(3)
      end
    end
  end

  describe 'PUT /expenses/:id' do
    let(:valid_attributes) { { expense: { title: 'Dinner at SteakHouse' } } }

    before { put "/expenses/#{expense_two_id}", params: valid_attributes }

    context 'when an expense does not exist in database' do
      let(:expense_two_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Expense with 'id'=0/)
      end
    end

    context 'with valid attributes when an expense exists in database' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the details of an expense' do
        expect(users.first.expenses.find(expense_two_id).title).to match(/Dinner at SteakHouse/)
      end
    end
  end

  describe 'DELETE /expenses/:id' do
    before { delete "/expenses/#{expense_one_id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    before { get "/lists/#{list_two_id}/expenses" }

    it 'decreases the count of expenses in the database' do
      expect(json.size).to eq(4)
      expect(users.second.expenses.size).to eq(json.size)
    end
  end
end
