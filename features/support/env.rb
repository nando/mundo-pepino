# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/app/config/environment')
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

require 'webrat/rails'

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
require 'webrat/rspec-rails'

require 'mundo_pepino'

Before do
  [ Orchard,
    Terrace,
    Crop,
    Fertilizer,
    Tomato,
    Chard,
    Pepino
  ].each { |model| model.destroy_all }
end

String.model_mappings = {
  /huert[oa]s?$/i            => Orchard,
  /bancal(es)?$/i           => Terrace,
  /cultivos?$/i             => Crop,
  /(abono|fertilizante)s?$/i => Fertilizer,
  /tomates?$/i		    => Tomato,
  /acelgas?$/i		    => Chard,
  /pepinos?$/i		    => Pepino
}

String.field_mappings = {
  /[Ááa]reas?$/i    => :area,
  /color(es)?$/i   => :color,
  /latitud(es)?$/i => :latitude,
  /longitud(es)?/i => :length,
  /pesos?/i        => :weight,
  /di[áa]metros?/i => :diameter,
  /matas?$/i       => :plants,
  /variedad(es)?$/i           => :variety,
  /campos? de texto/i         => :text_field,
  /[áa]reas? de texto/i       => :textarea,
  /tipos? de cultivos?/i      => :orchard_type,
  /nacionalidad/i             => :nationality,
  /fichero adjunto/i          => :file_field,
  /casilla seleccionada/i     => :selected_check,
  /casilla sin seleccionar/i  => :unselected_check,
  /Orchard::longitud(es)?$/   => :longitude
}


class MiMundo < MundoPepino
  include FixtureReplacement
  # Helpers específicos de nuestras features
end

World do
  MiMundo.new
end
