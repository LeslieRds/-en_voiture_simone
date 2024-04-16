class AddUserIdToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :user_id, :integer
    add_index :cars, :user_id  # Ajoute un index sur user_id pour améliorer les performances des requêtes
  end
end
