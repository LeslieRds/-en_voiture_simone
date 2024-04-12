class AddOwnerModeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :owner_mode, :boolean, default: false
  end
end
