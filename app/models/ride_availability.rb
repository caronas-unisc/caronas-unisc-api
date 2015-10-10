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
end
