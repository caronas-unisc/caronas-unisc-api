class Ride < ActiveRecord::Base
  has_many :messages
  belongs_to :giver_availability, class_name: 'RideAvailability', foreign_key: 'giver_availability_id'
  belongs_to :receiver_availability, class_name: 'RideAvailability', foreign_key: 'receiver_availability_id'

  validates :status, presence: true
  validates :receiver_availability_id, presence: true
  validates :giver_availability_id, presence: true
  validates :giver_availability_id, uniqueness: { scope: :receiver_availability_id }

  # do not allow accepting rides for availabilities that are already full
  validate do |ride|
    if ride.status_changed? && ride.accepted? && ride.giver_availability.full?
      ride.errors[:base] << 'The car is full'
    end
  end

  enum status: [:pending, :accepted]

  def as_json(options = {})
    super(only: [:id, :status])
  end
end