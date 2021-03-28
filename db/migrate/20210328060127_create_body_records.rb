class CreateBodyRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :body_records do |t|

      t.timestamps
    end
  end
end
