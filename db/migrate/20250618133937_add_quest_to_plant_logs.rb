class AddQuestToPlantLogs < ActiveRecord::Migration[7.2]
  def change
    add_reference :plant_logs, :quest, null: true, foreign_key: true
  end
end
