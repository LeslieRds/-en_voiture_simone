class Car < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  validates :brand, :model, :address, :year_of_production, :price_per_day, :np_passenger, :description, :city, :zipcode, presence: true
  validates :price_per_day, numericality: { greater_than: 0 }
  validates :year_of_production, numericality: { greater_than: 1990 }
  validates :nb_passenger, numericality: { greater_than: 2 }

  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_address?
end
