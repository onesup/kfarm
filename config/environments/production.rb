Kfarm::Application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.js_compressor = :uglifier
  config.assets.compile = true
  config.assets.digest = true
  config.assets.version = '1.0'
  config.log_level = :debug
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  # config.log_formatter = ::Logger::Formatter.new

  config.action_mailer.default_url_options = { :host => 'famrfarmmentor.org' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  if File.exists? ("#{Rails.root}/config/email.yml")
    EMAIL_CONFIG = YAML.load_file("#{Rails.root}/config/email.yml")[Rails.env]
  else
    EMAIL_CONFIG = {user_name: "temp@temp.org", password: "temp"}
  end
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "farmfarmmentor.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: EMAIL_CONFIG[:user_name],
    password: EMAIL_CONFIG[:password]
  }
  
end
