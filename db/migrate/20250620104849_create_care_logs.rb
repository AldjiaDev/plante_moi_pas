class CreateCareLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :care_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plant, null: false, foreign_key: true
      t.boolean :watered
      t.boolean :quest_done
      t.string :mood
      t.text :quest_response
      t.date :date

      t.timestamps
    end
  end
end
