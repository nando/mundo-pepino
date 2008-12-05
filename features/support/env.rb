# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

require 'webrat/rails'

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
#require 'webrat/rspec-rails'

require 'mundo-pepino'
String.number_mappings = {
  /una?/i => 1,
  :dos    => 2,
  :tres   => 3 }

String.model_mappings = {
  /huert[oa]s?/i => Orchard
}

String.field_mappings = {
  /nombres?/i => :name
}

String.url_mappings = {
  /la (portada|home)/i => '/'
}

World do
  MundoPepino.new
end
