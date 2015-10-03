module PasswordReset
  extend ActiveSupport::Concern

  module ClassMethods
    def find_by_active_password_reset_token(token)
      where('password_reset_token = ? AND password_reset_sent_at > ?', token, 1.hour.ago).first
    end
  end

  def send_password_reset
    update!(
      password_reset_token: generate_token,
      password_reset_sent_at: Time.zone.now
    )

    UserMailer.password_reset(self).deliver_now
  end

  private

  def generate_token
    token = nil
    begin
      token = SecureRandom.urlsafe_base64(50)
    end while self.class.exists?(password_reset_token: token)

    token
  end
end