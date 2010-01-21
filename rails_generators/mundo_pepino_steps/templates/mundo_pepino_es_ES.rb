require 'mundo_pepino'
require 'mundo_pepino/es_ES/matchers'
require 'mundo_pepino/es_ES/mappings'

MundoPepino.configure do |config|
  config.models_to_clean = [
    # MODELOS PARA LIMPIAR antes de cada escenario,
    # por ejemplo:
    # Orchard, Terrace, Crop...
  ]

  config.model_mappings = {
    # TRADUCCIÓN DE MODELOS AQUÍ, por ejemplo:
    # /^huert[oa]s?/i            => Orchard,
    # /^bancal(es)?$/i           => Terrace,
    # /^cultivos?$/i             => Crop...
  }

  config.field_mappings = {
    # TRADUCCIÓN DE CAMPOS AQUÍ:
    # /^[Ááa]reas?$/i    => 'area',
    # /^color(es)?$/i   => 'color',
    # /^latitud(es)?$/i => 'latitude',
    # /^longitud(es)?/i => 'length'
    #
    # TRADUCCIÓN ESPECÍFICA PARA UN MODELO
    # /^Orchard::longitud(es)?$/   => 'longitude'
  }

  config.page_mappings = {
    # TRADUCCIÓN DE RUTAS/URLS AQUÍ
    # Hardcoded
    #/^la página de registro/i => '/users/new',
    # From app routes:
    #/^la página de inicio de sesión/i => lambda {
    #  MundoPepino.world.new_session_path
    #},
    # And the fancy one: specific resource page
    #/^la página de(?:l| la) (.+) ["'](.+)['"]$/ => lambda {|captures|
    #  if model = captures[0].to_model
    #    MundoPepino.world.send "#{model.name.underscore}_path", model.find_by_name(captures[1])
    #  end
    #}
  }
end

Before do
  MundoPepino.clean_models
end

#module MundoPepino
#  # Helpers específicos de nuestras features que necesiten estar 
#  # "incluidos" (no extendidos), por ejemplo:
#  include FixtureReplacement # probado!
#  include Machinist # probado!
#end
# # Si utilizas factory_girl # probado!
# require 'factory_girl'
# #Definición de las factorias equivalente a example_data.rb en fixture_replacement
# require File.expand_path(File.dirname(__FILE__) + '/app/db/factories')
