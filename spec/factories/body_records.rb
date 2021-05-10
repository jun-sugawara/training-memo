FactoryBot.define do
  factory :body_record do
    association :user

    date             { 2021 - 0o5 - 0o1 }
    body_weight      { 60.5 }
    fat              { 18.5 }
    todays_condition { '良い' }
  end
end
