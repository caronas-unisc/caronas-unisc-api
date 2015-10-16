class RideAvailability < ActiveRecord::Base
  belongs_to :user

  enum availability_type: [:give, :receive]
  enum period: [:morning, :afternoon, :night]

  validates :date, presence: true
  validates :period, presence: true
  validates :availability_type, presence: true
  validates :period, presence: true
  validates :starting_location_address, presence: true, if: :receive?
  validates :starting_location_latitude, presence: true, if: :receive?
  validates :starting_location_longitude, presence: true, if: :receive?
  validates :available_places_in_car, presence: true, if: :give?

  def self.get_for_week(user, date)
    start_date = date.at_beginning_of_week(:sunday)
    end_date = date.at_end_of_week(:sunday)
    self.where(user: user, date: start_date..end_date)
  end
end
