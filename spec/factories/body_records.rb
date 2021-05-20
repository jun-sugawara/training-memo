FactoryBot.define do
  factory :body_record do
    association :user

    date             { Faker::Date.between(from: '2021-05-01', to: '2021-05-31') }
    body_weight      { Faker::Number.decimal(l_digits: 2) }
    fat              { Faker::Number.decimal(l_digits: 2) }
    todays_condition { '良い' }
  end
end
