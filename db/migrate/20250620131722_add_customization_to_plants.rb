class AddCustomizationToPlants < ActiveRecord::Migration[7.2]
  def change
    add_column :plants, :color, :string
    add_column :plants, :pot_style, :string
    add_column :plants, :accessory, :string
  end
end
