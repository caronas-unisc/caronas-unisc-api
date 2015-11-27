class Message < ActiveRecord::Base
  belongs_to :ride
  belongs_to :user

  validates :body, presence: true
  validates :user, presence: true

  def as_json(options = {})
    super(include: { user: { only: [:id, :name] } })
  end
end
