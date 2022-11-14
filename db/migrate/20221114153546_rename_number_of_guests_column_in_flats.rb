class RenameNumberOfGuestsColumnInFlats < ActiveRecord::Migration[7.0]
  def change
    rename_column :flats, :number_of_guests, :capacity
  end
end
