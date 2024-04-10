class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.integer :year_of_production
      t.string :address
      t.integer :price_per_day

      t.timestamps
    end
  end
end
