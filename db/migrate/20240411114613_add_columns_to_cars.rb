class AddColumnsToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :zipcode, :integer
    add_column :cars, :city, :string
    add_column :cars, :nb_passenger, :integer
  end
end
