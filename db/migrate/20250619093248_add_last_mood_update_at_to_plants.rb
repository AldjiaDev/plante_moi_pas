class AddLastMoodUpdateAtToPlants < ActiveRecord::Migration[7.2]
  def change
    add_column :plants, :last_mood_update_at, :datetime
  end
end
