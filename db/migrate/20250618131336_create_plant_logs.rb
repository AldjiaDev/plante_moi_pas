class CreatePlantLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :plant_logs do |t|
      t.references :plant, null: false, foreign_key: true
      t.date :date
      t.boolean :watered
      t.boolean :quest_done
      t.string :mood

      t.timestamps
    end
  end
end
