class CreateRideAvailability < ActiveRecord::Migration
  def change
    create_table :ride_availabilities do |t|
      t.integer :user_id, null: false
      t.integer :availability_type, null: false
      t.date :date, null: false
      t.integer :period, null: false
      t.text :starting_location_address, null: false
      t.float :starting_location_latitude, null: false
      t.float :starting_location_longitude, null: false

      t.timestamps null: false
    end
  end
end
