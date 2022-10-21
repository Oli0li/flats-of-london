class BookingsController < ApplicationController
  def create
    @flat = Flat.find(params[:flat_id])
    # @booking = Booking.new(user: current_user, flat: @flat, start_date: params[:start_date], end_date: params[:end_date])
    # @booking = Booking.new
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @flat
    if @booking.save
      redirect_to root_path
    else
      render "flats/show", status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
