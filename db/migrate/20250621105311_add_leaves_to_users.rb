class AddLeavesToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :leaves, :integer, default: 0, null: false
  end
end
