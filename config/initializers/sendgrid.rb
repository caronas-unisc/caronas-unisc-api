ActionMailer::Base.smtp_settings = {
  user_name: ENV['CARONASUNISC_SENDGRID_USERNAME'],
  password: ENV['CARONASUNISC_SENDGRID_PASSWORD'],
  domain: ENV['CARONASUNISC_SENDGRID_DOMAIN'],
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}