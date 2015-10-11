class AddAvailablePlacesInCarToRideAvailability < ActiveRecord::Migration
  def change
    add_column :ride_availabilities, :available_places_in_car, :integer
  end
end
