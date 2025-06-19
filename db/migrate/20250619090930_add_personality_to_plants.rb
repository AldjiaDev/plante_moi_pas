class AddPersonalityToPlants < ActiveRecord::Migration[7.2]
  def change
    add_column :plants, :personality, :string
  end
end
