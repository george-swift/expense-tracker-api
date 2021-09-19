FactoryBot.define do
  factory :expense do
    title { "Expense#{SecureRandom.hex(2)}" }
    amount { 25 }
    date { Faker::Date.between(from: '2021-01-01', to: '2021-08-01') }
    notes { Faker::Lorem.word }
    list
  end
end
