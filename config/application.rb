require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Foosball
  class Application < Rails::Application
    # ...Insert lots of example comments here...

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters << :password
    
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    
    config.autoload_paths += %W( #{Rails.root}/app/sweepers #{Rails.root}/app/services #{Rails.root}/app/lib )
    config.action_controller.page_cache_directory = Rails.root.to_s + "/public/cache"

    # Enable the asset pipeline
    config.assets.enabled = true
     
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
     
    # Change the path that assets are served from
    # config.assets.prefix = "/assets"
  end
end
