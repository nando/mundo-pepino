require 'mundo_pepino_es_ES'

Webrat.configure do |config|
  config.mode = :rails
end

MundoPepino::ModelsToClean = [
  # MODELOS PARA LIMPIAR antes de cada escenario,
  # por ejemplo:
  # Orchard, Terrace, Crop...
]

String.model_mappings = {
  # TRADUCCIÓN DE MODELOS AQUÍ, por ejemplo:
  # /^huert[oa]s?/i            => Orchard,
  # /^bancal(es)?$/i           => Terrace,
  # /^cultivos?$/i             => Crop...
}

String.field_mappings = {
  # TRADUCCIÓN DE CAMPOS AQUÍ:
  # /^[Ááa]reas?$/i    => 'area',
  # /^color(es)?$/i   => 'color',
  # /^latitud(es)?$/i => 'latitude',
  # /^longitud(es)?/i => 'length'
  #
  # TRADUCCIÓN ESPECÍFICA PARA UN MODELO
  # /^Orchard::longitud(es)?$/   => 'longitude'
}


Before do
  MundoPepino::ModelsToClean.each { |model| model.destroy_all }
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

World(MundoPepino)
