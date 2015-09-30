class Session < ActiveRecord::Base
  belongs_to :user
  has_secure_token

  def as_json(options = {})
    super(only: [:token])
  end
end
