require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EmergedApi
  class Application < Rails::Application
    config.load_defaults 5.2
    
    # Change primary key type to uuid
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
    
    config.api_only = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, :methods => %i[get post patch put delete options]
      end
    end
  end
end
