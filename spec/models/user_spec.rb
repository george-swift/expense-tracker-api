require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'username and password validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:username).is_at_most(50) }
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'email validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:email).is_at_most(255) }

    invalid_addresses = %w[foo.bar#example.com foo.bar foo@bar+baz.com user_at_foo.org user@example,com]
    invalid_addresses.each do |invalid_address|
      it { should_not allow_value(invalid_address).for(:email) }
    end

    valid_addresses = %w[
      foo.bar@sub.example.co.id user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn
    ]
    valid_addresses.each do |valid_address|
      it { should allow_value(valid_address).for(:email) }
    end
  end

  describe 'associations' do
    it { should have_many(:lists).order(created_at: :desc).dependent(:destroy) }
  end
end
