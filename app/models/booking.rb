class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates :start_date, :end_date, presence: true, availability: true
  validates :number_of_guests, presence: true
  validates :number_of_guests, numericality: { only_integer: true, greater_than: 0 }
  validate :end_date_after_start_date
  validates_with OverlapFreeValidator, attributes: [:start_date, :end_date]

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
