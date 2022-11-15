class BookingsController < ApplicationController
  def create
    # flat = Flat.find(params[:flat_id])
    # booking  = Order.create!(teddy: teddy, teddy_sku: teddy.sku, amount: teddy.price, state: 'pending', user: current_user)

    # session = Stripe::Checkout::Session.create(
    #   payment_method_types: ['card'],
    #   line_items: [{
    #     name: teddy.sku,
    #     images: [teddy.photo_url],
    #     amount: teddy.price_cents,
    #     currency: 'eur',
    #     quantity: 1
    #   }],
    #   success_url: order_url(order),
    #   cancel_url: order_url(order)
    # )

    # order.update(checkout_session_id: session.id)
    # redirect_to new_order_payment_path(order)



    # ---------
    # raise
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @flat
    @booking.status = "pending"
    @booking.amount = @booking.get_amount
    if @booking.save
      redirect_to dashboard_path
    else
      render 'flats/show', status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_of_guests)
  end
end
