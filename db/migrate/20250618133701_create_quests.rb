class CreateQuests < ActiveRecord::Migration[7.2]
  def change
    create_table :quests do |t|
      t.string :title
      t.text :description
      t.string :quest_type
      t.integer :reward_points
      t.boolean :active

      t.timestamps
    end
  end
end
