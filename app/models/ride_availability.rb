class RideAvailability < ActiveRecord::Base
  has_many :giver_rides, class_name: 'Ride', foreign_key: 'giver_availability_id', dependent: :destroy
  has_many :receiver_rides, class_name: 'Ride', foreign_key: 'receiver_availability_id', dependent: :destroy
  belongs_to :user

  enum availability_type: [:give, :receive]
  enum period: [:morning, :afternoon, :night]

  after_update :destroy_rides_if_type_changed

  validates :date, presence: true
  validates :period, presence: true
  validates :availability_type, presence: true
  validates :period, presence: true
  validates :starting_location_address, presence: true, if: :receive?
  validates :starting_location_latitude, presence: true, if: :receive?
  validates :starting_location_longitude, presence: true, if: :receive?
  validates :available_places_in_car, presence: true, if: :give?

  def remaining_places_in_car
    available_places_in_car - giver_rides.accepted.count if give?
  end

  def has_places_available?
    remaining_places_in_car > 0
  end

  def full?
    !has_places_available?
  end

  def create_pending_ride_for!(user)
    receiver_availability = user.ride_availabilities.receive.find_by!(
      period: self.class.periods[period],
      date: date
    )

    ride = Ride.find_or_create_by(giver_availability: self, receiver_availability: receiver_availability) do |ride|
      ride.status = Ride.statuses[:pending]
    end
  end

  def destroy_rides_if_type_changed
    if availability_type_changed?
      giver_rides.destroy_all
      receiver_rides.destroy_all
    end
  end

  def as_json(options = {})
    super(include: { user: { only: [:id, :name] } })
  end

  def self.get_for_week(user, date)
    start_date = date.at_beginning_of_week(:sunday)
    end_date = date.at_end_of_week(:sunday)
    self.where(user: user, date: start_date..end_date)
  end

  def self.repeat_last_week!(user)
    today = Time.zone.now
    get_for_week(user, today).destroy_all
    
    ActiveRecord::Base.transaction do
      get_for_week(user, today - 1.week).each do |past_availability|
        availability = past_availability.dup
        availability.date = availability.date + 1.week
        availability.save!
      end
    end

    get_for_week(user, today)
  end
end
