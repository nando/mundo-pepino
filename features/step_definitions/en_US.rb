require 'mundo_pepino/en_US'

MundoPepino.configure do |config|
  config.models_to_clean = [
    Orchard,
    Terrace,
    Crop,
    Fertilizer,
    Tomato,
    Chard,
    Pepino,
    Lettuce,
    Sprinkler
  ]
  config.model_mappings = {
    /^orchards?$/i    => Orchard,
    /^terraces?$/i    => Terrace,
    /^crops?$/i       => Crop,
    /^fertilizers?$/i => Fertilizer,
    /^tomatoes?$/i    => Tomato,
    /^chards?$/i		  => Chard,
    /^cucumbers?$/i	  => Pepino,
    /^sprinklers?$/i  => Sprinkler,
    /^lettuces?$/i    => Lettuce
  }

#config.field_mappings = {
#  /^[Ááa]reas?$/i    => :area,
#  /^color(es)?$/i   => :color,
#  /^latitud(es)?$/i => :latitude,
#  /^longitud(es)?/i => :length,
#  /^pesos?/i        => :weight,
#  /^di[áa]metros?/i => :diameter,
#  /^matas?$/i       => :plants,
#  /^variedad(es)?$/i           => :variety,
#  /^campos? de texto/i         => :text_field,
#  /^[áa]reas? de texto/i       => :textarea,
#  /^tipos? de cultivos?/i      => :orchard_type,
#  /^nacionalidad/i             => :nationality,
#  /^fichero adjunto/i          => :file_field,
#  /^casilla seleccionada/i     => :selected_check,
#  /^casilla sin seleccionar/i  => :unselected_check,
#  /^Orchard::longitud(es)?$/   => :longitude,
#  /^cultivad[oa]$/             => :cultivated,
#  /^caudal(es)?$/i             => :flow,
#  /^unidad(es)? caudal(es)?$/i => :flow_units,
#  /^estaci[oó]n(es)?$/i        => :season,
#  /^huerto de nacimiento$/i    => :orchard_of_birth,
#  /^hora de comenzar a regar$/i => :start_watering,
#  /^hora de terminar de regar$/i => :stop_watering,
#  /^precio$/i                  => :price
#}
#
#config.relation_model_mappings = {
#  /^orchard_of_birth$/i => Orchard
#}
#
#config.url_mappings.merge!(
#  /^la página de registro/i    => '/welcome/signup'
#)
#
end

Before do
  MundoPepino.clean_models
end

module MundoPepino
  include FixtureReplacement
end
