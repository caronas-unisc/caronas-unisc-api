class RemoveNotNullConstraintsFromStartingLocation < ActiveRecord::Migration
  def change
    change_column :ride_availabilities, :starting_location_address, :text, null: true
    change_column :ride_availabilities, :starting_location_latitude, :float, null: true
    change_column :ride_availabilities, :starting_location_longitude, :float, null: true
  end
end
