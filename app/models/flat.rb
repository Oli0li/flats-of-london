class Flat < ApplicationRecord
  belongs_to :user
  # Source of geocoding
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo

  validates :name, :address, :description, :price_per_night, :number_of_guests, :user_id, presence: true
  validates :description, length: { minimum: 10, maximum: 400 }
  validates :number_of_guests, numericality: { greater_than: 0 }
  validates :price_per_night, numericality: { greater_than_or_equal_to: 0 }
end
