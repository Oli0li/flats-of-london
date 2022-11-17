class MonetizePriceColumnInFlats < ActiveRecord::Migration[7.0]
  def change
    change_table :flats do |t|
      t.monetize :price_per_night, currency: { present: false }
    end
  end
end
