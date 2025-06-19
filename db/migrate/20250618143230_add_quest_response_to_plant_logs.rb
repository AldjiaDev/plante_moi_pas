class AddQuestResponseToPlantLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :plant_logs, :quest_response, :text
  end
end
