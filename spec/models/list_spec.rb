require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_length_of(:name).is_at_most(50) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_db_index(%i[user_id created_at]) }
  end
end
