class OverlapFreeValidator < ActiveModel::EachValidator
  def validate(record)
    bookings = Booking.where(["flat_id =?", record.flat_id])
    date_ranges = bookings.map { |b| b.start_date..b.end_date }

    date_ranges.each do |range|
      if (record.start_date..record.end_date).include? range
        record.errors.add(:start_date, "This booking is overlapping with another booking.")
      end
    end
  end
end
