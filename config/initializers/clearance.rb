Clearance.configure do |config|
  config.mailer_sender = "Takeaways App <noreply@#{Rails.application.config.app_domain}>"
  config.allow_sign_up = false
end
