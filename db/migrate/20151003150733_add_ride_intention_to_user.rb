class AddRideIntentionToUser < ActiveRecord::Migration
  def change
    add_column :users, :ride_intention, :integer, default: 0, null: false
  end
end
