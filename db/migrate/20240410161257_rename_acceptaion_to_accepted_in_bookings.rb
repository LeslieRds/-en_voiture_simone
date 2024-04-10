class RenameAcceptaionToAcceptedInBookings < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookings, :acceptaion, :accepted
  end
end
