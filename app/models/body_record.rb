class BodyRecord < ApplicationRecord
  #アソシエーション記述

  with_options presence: true do
    validates :date
    validates :body_weight
    validates :fat
  end

end
