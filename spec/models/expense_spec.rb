require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_presence_of(:date) }
    it do
      should validate_numericality_of(:amount)
        .is_greater_than(0)
    end
    it { should validate_length_of(:notes).is_at_most(255) }
  end

  describe 'associations' do
    it { should belong_to(:list) }
  end
end
