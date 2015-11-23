class Ride < ActiveRecord::Base
  belongs_to :giver_availability, class_name: 'RideAvailability', foreign_key: 'giver_availability_id'
  belongs_to :receiver_availability, class_name: 'RideAvailability', foreign_key: 'receiver_availability_id'

  validates :giver_availability_id, uniqueness: { scope: :receiver_availability_id }

  enum status: [:pending, :accepted]

  def self.create_ride_for_availability(user, giver_availability)
    user.ride_availabilities.receive.where(
      period: RideAvailabilities.periods[:night],
      
    )
  end

  def as_json(options = {})
    super(only: [:id, :status])
  end
end
