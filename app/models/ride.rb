class Ride < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :giver_availability, class_name: 'RideAvailability', foreign_key: 'giver_availability_id'
  belongs_to :receiver_availability, class_name: 'RideAvailability', foreign_key: 'receiver_availability_id'

  enum status: [:pending, :accepted]

  after_create :send_asked_ride_notification
  after_update :send_accepted_ride_notification

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

  def send_asked_ride_notification
    if pending?
      Notification.create(
        user: giver_availability.user,
        type: Notification.types[:asked_ride],
        info: {
          date: giver_availability.date,
          period: giver_availability.period,
          user: receiver_availability.user.name
        }
      )
    end
  end

  def send_accepted_ride_notification
    if status_was == 'pending' && accepted?
      Notification.create(
        user: receiver_availability.user,
        type: Notification.types[:accepted_ride],
        info: {
          date: receiver_availability.date,
          period: receiver_availability.period,
          user: giver_availability.user.name
        }
      )
    end
  end

  def as_json(options = {})
    super(only: [:id, :status])
  end
end