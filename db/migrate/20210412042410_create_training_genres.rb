class CreateTrainingGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :training_genres do |t|
      t.string      :part,            null: false
      t.string      :event,           null: false
      t.timestamps
    end
  end
end
