class CreateBodyRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :body_records do |t|
      t.date       :date,            null: false
      t.float      :body_weight,     null: false
      t.float      :fat,             null: false
      t.integer    :todays_condition
      t.references :user,         foreign_key: true
      t.timestamps
    end
  end
end
