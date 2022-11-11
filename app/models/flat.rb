class Flat < ApplicationRecord
  belongs_to :user
  # Source of geocoding
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo
  has_many :bookings

  validates :name, :address, :description, :price_per_night, :number_of_guests, :user_id, presence: true
  validates :description, length: { minimum: 10, maximum: 400 }
  validates :number_of_guests, numericality: { greater_than: 0 }
  validates :price_per_night, numericality: { greater_than_or_equal_to: 0 }

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end

  def day_before_unavailable
    self.unavailable_dates.map { |date_range| date_range[:from] }
  end
end
