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
    
    config.autoload_paths += %W( #{Rails.root}/app/sweepers )
    config.action_controller.page_cache_directory = Rails.root.to_s + "/public/cache"
    CalendarDateSelect.format = :iso_date
  end
end