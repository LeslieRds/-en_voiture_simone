class RemoveOverviewOwnerModeFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :overview, :text
    remove_column :users, :owner_mode, :boolean
  end
end
