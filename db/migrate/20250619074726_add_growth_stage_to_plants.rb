class AddGrowthStageToPlants < ActiveRecord::Migration[7.2]
  def change
    add_column :plants, :growth_stage, :string
  end
end
