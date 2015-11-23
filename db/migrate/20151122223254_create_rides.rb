class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :status
      t.integer :giver_availability_id
      t.integer :receiver_availability_id

      t.timestamps null: false
    end
  end
end
