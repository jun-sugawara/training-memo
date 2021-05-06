class BodyRecord < ApplicationRecord
  belongs_to :user, optional: true

  with_options presence: true do
    validates :date
    validates :body_weight, numericality: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください"}
    validates :fat, numericality: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください"}
  end
end
