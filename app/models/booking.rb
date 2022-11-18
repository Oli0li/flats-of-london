class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  monetize :amount_cents

  validates :start_date, :end_date, presence: true, availability: true
  validates :number_of_guests, presence: true
  validates :number_of_guests, numericality: { only_integer: true, greater_than: 0 }
  validate :end_date_after_start_date

  def get_amount
    return 0 if end_date.nil? || start_date.nil?
    number_of_nights = end_date - start_date
    number_of_nights * flat.price_per_night
  end

  def self.display_bookings(time, logged_user)
    case time
    when "future" then get_confirmed_bookings(logged_user).select { |b| DateTime.now < b.start_date }
    when "past" then get_confirmed_bookings(logged_user).select { |b| b.start_date < DateTime.now }
    when "present" then get_confirmed_bookings(logged_user).select { |b| (b.start_date..b.end_date).include?(DateTime.now) }
    end
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  private_class_method def self.get_confirmed_bookings(logged_user)
    user = User.find(logged_user.id)
    user.bookings.where(status: "confirmed").order(:start_date)
  end
end
