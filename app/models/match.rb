class Match
  include ActiveModel::Model

  def initialize(availability, ride)
    @availability = availability
    @ride = ride
  end

  def as_json(options = {})
    json = {
      availability_id: @availability.id,
      period: @availability.period,
      date: @availability.date,
      user_name: @availability.user.name,
      ride: @ride
    }

    if @availability.give?
      json[:remaining_places_in_car] = @availability.remaining_places_in_car
    else
      json[:starting_location_address] = @availability.starting_location_address
      json[:starting_location_latitude] = @availability.starting_location_latitude
      json[:starting_location_longitude] = @availability.starting_location_longitude
    end

    json
  end
end