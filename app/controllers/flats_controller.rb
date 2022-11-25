class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_flat, only: [:show, :update, :destroy]
  before_action :validate_user, only: [:edit]

  def index
    @flats = Flat.all.order(created_at: :desc)
    # Now we give Mapbox a list of coordinates for all flats
    # Same as : @markers = Flat.where.not(latitude: nil, longitude: nil)
    # Flat.geocoded = returns all instances of flats with latitude and longitude
    @markers = Flat.geocoded.map do |flat|
      {
        lng: flat.longitude,
        lat: flat.latitude,
        info_window: render_to_string(partial: "info_window", locals: {flat: flat}),
        image_url: helpers.asset_url("flats_of_london_marker.png")
      }
    end
  end

  def show
    @booking = Booking.new
    @marker = [{
      lng: @flat.longitude,
      lat: @flat.latitude,
      info_window: render_to_string(partial: "info_window", locals: {flat: @flat}),
      image_url: helpers.asset_url("flats_of_london_marker.png")
    }]
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @flat.update(flat_params)
      redirect_to flat_path(@flat)
      flash[:success] = "The flat details have been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_path, status: :see_other
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :capacity, photos: [])
  end

  def validate_user
    @flat = Flat.find(params[:id])
    if current_user != @flat.user
      redirect_to root_path
      flash[:alert] = "You cannot amend flats that aren't yours."
    end
  end
end
