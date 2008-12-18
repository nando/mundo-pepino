# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/app/config/environment')
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

require 'webrat/rails'

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
#require 'webrat/rspec-rails'

require 'mundo-pepino'

Before do
  Orchard.destroy_all
  Fertilizer.destroy_all
end

String.model_mappings = {
  /huert[oa]s?/i => Orchard,
  /(abono|fertilizante)s?/i => Fertilizer
}

String.field_mappings.merge!({
  /[áa]reas?$/i => 'area',
  /latitud(es)?$/i => 'latitude',
  /longitud(es)?/i => 'longitude',
  /campos? de texto/i => 'text_field',
  /[áa]reas? de texto/i => 'textarea',
  /tipos? de cultivos?/i => 'orchard_type'
})


class MiMundo < MundoPepino 
  def entonces_campo_valor(campo, valor)
    if child_model = campo.to_model
      child = child_model.find_by_name(valor)
      (@then_resource.send child_model.name.downcase).should == child
    else
      (@then_resource.send campo.to_field).to_s.should == valor
    end
  end
end


World do
  MiMundo.new
end
