class RemoveOldPricePerNightColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :flats, :price_per_night, :integer
  end
end
