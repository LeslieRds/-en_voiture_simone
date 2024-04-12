class AddColmunsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :overview, :text
    add_column :users, :phone_number, :string
  end
end
