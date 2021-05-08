FactoryBot.define do
  factory :training_record do
    association :user

    date            { 2021-05-11 }
    training_event  { 1 }
    training_weight { 100.5 }
    reps            { 10 }
    set             { 3 }
  end
end
