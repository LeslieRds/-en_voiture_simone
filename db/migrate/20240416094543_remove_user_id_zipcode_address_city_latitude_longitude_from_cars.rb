class RemoveUserIdZipcodeAddressCityLatitudeLongitudeFromCars < ActiveRecord::Migration[7.0]
  def change
    remove_column :cars, :user_id
    remove_column :cars, :zipcode, :integer
    remove_column :cars, :address, :string
    remove_column :cars, :city, :string
    remove_column :cars, :latitude, :float
    remove_column :cars, :longitude, :float
  end
end
