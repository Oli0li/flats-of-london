class ChangePricePerNight < ActiveRecord::Migration[7.0]
  def change
    change_column_default :flats, :price_per_night_cents, nil
    change_column_null :flats, :price_per_night_cents, true
  end
end
