class TrainingRecord < ApplicationRecord
  belongs_to :user, optional: true
  has_many :training_genres

  with_options presence: true do
    validates :date
    validates :training_event
    # validates :training_weight
    # validates :reps
    # validates :set
  end

  with_options on: :confirm do
    validates_presence_of :training_weight
    validates_presence_of :reps
    validates_presence_of :set
  end
end
