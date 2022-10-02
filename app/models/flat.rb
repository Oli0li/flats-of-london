class Flat < ApplicationRecord
  validates :name, :address, :description, :price_per_night, :number_of_guests, presence: true
  validates :description, length: { minimum: 10, maximum: 400 }
  validates :number_of_guests, numericality: { greater_than: 0 }
  validates :price_per_night, numericality: { greater_than_or_equal_to: 0 }
end
