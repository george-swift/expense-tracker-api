FactoryBot.define do
  factory :user do
    username { 'Donny' }
    email { 'donny@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
