class Notification < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :user

  enum type: [:asked_ride, :accepted_ride]

  def as_json(options = {})
    super(only: [:id, :type, :info, :created_at])
  end
end
