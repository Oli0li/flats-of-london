class BookingsController < ApplicationController
  def create
    flat = Flat.find(params[:flat_id])
    booking = Booking.new(booking_params)
    booking.user = current_user
    booking.flat = flat
    booking.status = "pending"
    booking.amount = booking.get_amount
    if booking.save
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            currency: 'gbp',
            unit_amount: booking.amount_cents,
            product_data: {
              name: flat.name,
              description: flat.description,
              images: [flat.photos.first.url]
            },
          },
          quantity: 1,
        }],
        mode: 'payment',
        success_url: dashboard_url,
        cancel_url: flat_url(flat)
      )

      booking.update(checkout_session_id: session.id)
      redirect_to new_flat_booking_payment_path(flat, booking)
    else
      render 'flats/show', status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_of_guests)
  end
end
