Apipie.configure do |config|
  config.app_name                = "BookStoreAPI"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  config.translate               = false
  config.default_locale          = nil
  config.validate                = false
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v1/**/*.rb"
end
