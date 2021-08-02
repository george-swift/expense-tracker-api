FactoryBot.define do
  factory :user do
    username { "Test#{SecureRandom.hex(3)}" }
    email { "#{SecureRandom.hex(4)}@example.com" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
