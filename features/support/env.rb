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

String.model_mappings = {
  /huert[oa]s?/i => Orchard,
  /(abono|fertilizante)s?/i => Fertilizer
}

String.field_mappings = {
  /[áa]reas?/i => 'area',
  /latitud(es)?/i => 'latitude',
  /longitud(es)?/i => 'longitude'
}

World do
  MundoPepino.new
end
