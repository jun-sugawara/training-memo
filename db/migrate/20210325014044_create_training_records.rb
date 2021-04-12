class CreateTrainingRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :training_records do |t|
      t.date       :date,            null: false
      t.integer    :training_event,  null: false
      t.integer    :training_weight, null: false
      t.integer    :reps,            null: false
      t.integer    :set,             null: false 
      t.references :user,            foreign_key: true
      t.timestamps
    end
  end
end
