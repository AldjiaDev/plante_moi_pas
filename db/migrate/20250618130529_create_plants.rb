class CreatePlants < ActiveRecord::Migration[7.2]
  def change
    create_table :plants do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.datetime :last_watered_at
      t.integer :consecutive_days_watered
      t.string :mood
      t.integer :leaves
      t.string :state

      t.timestamps
    end
  end
end
