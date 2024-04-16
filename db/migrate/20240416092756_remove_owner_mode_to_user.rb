class RemoveOwnerModeToUser < ActiveRecord::Migration[7.0]
  def change
    def up
      remove_column :User, :owner_mode
      remove_column :User, :overview
    end

    def down
      add_column :User, :owner_mode, :boolean
      add_column :User, :overview, :text
    end
  end
end
