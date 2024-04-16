class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  validates :brand, :model, :year_of_production, :price_per_day, :nb_passenger, :description, presence: true
  validates :price_per_day, numericality: { greater_than: 0 }
  validates :year_of_production, numericality: { greater_than: 1990 }
  validates :nb_passenger, numericality: { greater_than: 2 }
end
