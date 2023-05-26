require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RedNewsV4
  class Application < Rails::Application
    # Initialize configura
    #tion defaults for originally generated Rails version.

    config.middleware.use ActionDispatch::Cookies
    # config.middleware.use ActionDispatch::Session::CookieStore
    #config.middleware.insert_after(ActionDispatch::Cookies, ActionDispatch::Session::CookieStore)

    config.web_console.permissions = '10.0.2.2'
    config.web_console.permissions = '77.222.102.112'
    config.load_defaults 7.0
    config.web_console.whitelisted_ips = '77.222.102.112'
    config.web_console.whitelisted_ips = '198.16.74.45'
    config.active_storage.variant_processor = :mini_magick
    config.api_only = false
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
