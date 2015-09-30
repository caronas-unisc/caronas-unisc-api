class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def create_session
    Session.create(user: self)
  end

  def as_json(options = {})
    super(except: [:password_digest])
  end
end
