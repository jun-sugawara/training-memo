class TrainingRecord < ApplicationRecord
  # アソシエーション記述

  with_options presence: true do
    validates :date
    validates :training_event
    validates :training_weight
    validates :reps
    validates :set
  end
end
