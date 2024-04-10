class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  validates :brand, :model, :address, :year_of_production, :price_per_day, presence: true
  validates :price_per_day, numericality: { greater_than: 0 }
  validates :year_of_production, numericality: { greater_than: 1990 }
end
