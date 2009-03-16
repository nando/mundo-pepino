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

Webrat.configure do |config|
  config.mode = :rails
end

MundoPepino::ModelsToClean = [
  Orchard,
  Terrace,
  Crop,
  Fertilizer,
  Tomato,
  Chard,
  Pepino,
  Sprinkler
]

String.model_mappings = {
  /^huert[oa]s?$/i            => Orchard,
  /^bancal(es)?$/i           => Terrace,
  /^cultivos?$/i             => Crop,
  /^(abono|fertilizante)s?$/i => Fertilizer,
  /^tomates?$/i		    => Tomato,
  /^acelgas?$/i		    => Chard,
  /^pepinos?$/i		    => Pepino,
  /^aspersor(es)?$/i        => Sprinkler
}

String.field_mappings = {
  /^[Ááa]reas?$/i    => :area,
  /^color(es)?$/i   => :color,
  /^latitud(es)?$/i => :latitude,
  /^longitud(es)?/i => :length,
  /^pesos?/i        => :weight,
  /^di[áa]metros?/i => :diameter,
  /^matas?$/i       => :plants,
  /^variedad(es)?$/i           => :variety,
  /^campos? de texto/i         => :text_field,
  /^[áa]reas? de texto/i       => :textarea,
  /^tipos? de cultivos?/i      => :orchard_type,
  /^nacionalidad/i             => :nationality,
  /^fichero adjunto/i          => :file_field,
  /^casilla seleccionada/i     => :selected_check,
  /^casilla sin seleccionar/i  => :unselected_check,
  /^Orchard::longitud(es)?$/   => :longitude,
  /^cultivad[oa]$/             => :cultivated,
  /^caudal(es)?$/i             => :flow,
  /^unidad(es)? caudal(es)?$/i => :flow_units,
  /^estaci[oó]n(es)?$/i        => :season
}

String.url_mappings.merge!(
  /^la página de registro/i    => '/welcome/signup'
)

# Si utilizas factory_girl # probado!
#require 'factory_girl'
# Definición de las factorias equivalente a example_data.rb en fixture_replacement
#require File.expand_path(File.dirname(__FILE__) + '/app/db/factories')

class MiMundo < MundoPepino
  include FixtureReplacement
  # Helpers específicos de nuestras features
end

Before do
  MundoPepino::ModelsToClean.each { |model| model.destroy_all }
end

World do
  MiMundo.new
end
