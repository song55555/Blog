Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 12

  config.reset_password_within = 6.hours

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reconfirmable = true

  config.remember_for = 2.weeks

  config.sign_out_via = :delete

  config.scoped_views = true

  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
  config.mailer = false
end