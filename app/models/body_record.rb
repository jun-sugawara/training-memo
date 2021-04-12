class BodyRecord < ApplicationRecord
  belongs_to :user, optional: true

  with_options presence: true do
    validates :date
    validates :body_weight
    validates :fat
  end
end
