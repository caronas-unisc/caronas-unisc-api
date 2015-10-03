class User < ActiveRecord::Base
  has_secure_password

  enum ride_intention: [:give_and_receive_ride, :give_ride, :receive_ride]

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :ride_intention, presence: true

  def create_session
    Session.create(user: self)
  end

  def as_json(options = {})
    super(except: [:password_digest])
  end
end
