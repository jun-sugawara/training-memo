class TrainingRecord < ApplicationRecord
  belongs_to :user
  has_many :training_genres

  with_options presence: true do
    validates :date
    validates :training_event
    validates :training_weight, on: :next,  numericality: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' }
    validates :reps, on: :next,  numericality: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' }
    validates :set, on: :next
  end

  with_options on: :update do
    validates_presence_of :training_weight, numericality: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください"}
    validates_presence_of :reps, numericality: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください"}
    validates_presence_of :set
  end
end
