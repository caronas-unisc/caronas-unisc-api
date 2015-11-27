class MatchFinder
  def initialize(availability_model)
    @availability_model = availability_model
  end

  def find_give_matches_for_week(user, date)
    give_availabilities = user.ride_availabilities.give.order('date ASC, period ASC')
    matches = []

    give_availabilities.each do |availability|
      availability.giver_rides.each do |ride|
        matches << Match.new(ride.receiver_availability, ride)
      end
    end

    matches
  end

  def find_receive_matches_for_week(user, date)
    matches = []
    requests = @availability_model.get_for_week(user, date).receive

    if requests.any?
      query = generate_date_and_period_query(requests)
      givers_availabilities = @availability_model.where(*query).give.includes(:user).order('date ASC, period ASC')
    
      givers_availabilities.each do |availability|
        my_ride_availability = user.ride_availabilities.find_by(date: availability.date, period: RideAvailability.periods[availability.period])
        ride = Ride.find_by(receiver_availability: my_ride_availability)
        matches << Match.new(availability, ride)
      end
    end

    matches
  end

  private

  def generate_date_and_period_query(availabilities)
    query = []
    query << (['(date = ? AND period = ?)'] * availabilities.length).join(' OR ')

    availabilities.each do |a|
      query += [a[:date], a[:period]]
    end

    query
  end
end