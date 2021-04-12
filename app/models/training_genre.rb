class TrainingGenre < ApplicationRecord
    belongs_to :training_record

    with_options presence: true do
      validates :part
      validates :event
    end
end
