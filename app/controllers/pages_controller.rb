class PagesController < ApplicationController
  def dashboard
    @future_bookings = Booking.display_bookings("future", current_user)
    @past_bookings = Booking.display_bookings("past", current_user)
    @current_bookings = Booking.display_bookings("present", current_user)
    @my_properties = current_user.flats
  end
end
