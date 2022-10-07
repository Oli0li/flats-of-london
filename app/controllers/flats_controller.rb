class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_flat, only: [:show, :update, :destroy]

  def index
    @flats = Flat.all
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
    @flat.update(flat_params)
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
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :number_of_guests, :photo)
  end
end
