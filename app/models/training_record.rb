class TrainingRecord < ApplicationRecord
  belongs_to :user, optional: true
  has_many :training_genres

  with_options presence: true do
    validates :date
    validates :training_event
    validates :training_weight
    validates :reps
    validates :set
  end
end
