class TrainingGenre < ApplicationRecord
    # アソシエーション記述

    with_options presence: true do
      validates :part
      validates :event
    end
end
