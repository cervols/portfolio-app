require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PortfolioApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # generators setup
    config.generators do |g|
      g.orm :active_record
      g.assets false
      g.helper = false
      g.test_framework :rspec,
        view_specs: false,
        routing_specs: false
    end
  end
end
