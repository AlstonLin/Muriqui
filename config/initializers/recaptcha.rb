Recaptcha.configure do |config|
  config.public_key  = APP_CONFIG['recaptcha_api_key']
  config.private_key = APP_CONFIG['recaptcha_secret_key']
  config.api_version = 'v2'
end
