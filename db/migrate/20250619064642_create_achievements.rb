class CreateAchievements < ActiveRecord::Migration[7.2]
  def change
    create_table :achievements do |t|
      t.string :code
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
