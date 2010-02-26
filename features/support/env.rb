# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/app/config/environment')

require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'cucumber/rails/rspec'
require 'cucumber/rails/world'
require 'cucumber/rails/active_record'
require 'cucumber/web/tableish'

# Whether or not to run each scenario within a database transaction.
#
# If you leave this to true, you can turn off traqnsactions on a
# per-scenario basis, simply tagging it with @no-txn
Cucumber::Rails::World.use_transactional_fixtures = true

# Whether or not to allow Rails to rescue errors and render them on
# an error page. Default is false, which will cause an error to be
# raised.
#
# If you leave this to false, you can turn on Rails rescuing on a
# per-scenario basis, simply tagging it with @allow-rescue
ActionController::Base.allow_rescue = false

require 'webrat'
require 'webrat/core/matchers'
require 'cucumber/webrat/element_locator' # Deprecated in favor of #tableish - remove this line if you don't use #element_at or #table_at

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

require 'cucumber/rails/rspec'
