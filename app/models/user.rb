class User < ActiveRecord::Base
  include PasswordReset

  has_secure_password

  enum ride_intention: [:give_and_receive_ride, :give_ride, :receive_ride]

  attr_accessor :validate_password
  attr_accessor :validate_password_confirmation

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :ride_intention, presence: true
  validates :password, confirmation: true, if: lambda { validate_password_confirmation }
  validates :password, length: { minimum: 6 }, if: lambda { validate_password }

  def create_session
    Session.create(user: self)
  end

  def as_json(options = {})
    super(only: [:id, :name, :email, :ride_intention, :created_at])
  end
end
