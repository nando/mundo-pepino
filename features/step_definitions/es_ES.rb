require 'mundo_pepino/es_ES'

# Hack to manage that Webrat uses strftime(%B) to select months at forms
class Time
  alias :strftime_nolocale :strftime
  def strftime(format)
    format = format.dup
    format.gsub!(/%B/, I18n.translate('date.month_names')[self.mon])
    self.strftime_nolocale(format)
  end
end

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
    /^huert[oa]s?$/i            => Orchard,
    /^bancal(es)?$/i            => Terrace,
    /^cultivos?$/i              => Crop,
    /^(abono|fertilizante)s?$/i => Fertilizer,
    /^tomates?$/i               => Tomato,
    /^acelgas?$/i               => Chard,
    /^pepinos?$/i               => Pepino,
    /^aspersor(es)?$/i          => Sprinkler,
    /^lechugas?$/i              => Lettuce,
    /^huerto de nacimiento$/i   => Orchard
  }
  config.field_mappings = {
    /^[Ááa]reas?$/i              => :area,
    /^color(es)?$/i              => :color,
    /^latitud(es)?$/i            => :latitude,
    /^longitud(es)?/i            => :length,
    /^pesos?/i                   => :weight,
    /^di[áa]metros?/i            => :diameter,
    /^matas?$/i                  => :plants,
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
    /^estaci[oó]n(es)?$/i        => :season,
    /^huerto de nacimiento$/i    => :orchard_of_birth,
    /^hora de comenzar a regar$/i => :start_watering,
    /^hora de terminar de regar$/i => :stop_watering,
    /^precio$/i                  => :price,
    /^Pepino::nombre$/i          => :title
  }
  config.relation_model_mappings = {
    /^orchard_of_birth$/i => Orchard
  }
  config.url_mappings = {
    /^la página de registro/i => lambda {
      MundoPepino.world.url_for(:only_path=>true,
        :controller=>'welcome', :action => 'signup')
    },
    /^la página de inicio de sesión/i => lambda {
      MundoPepino.world.new_session_path
    },
    # the fancy one: specific resource page
    /^la página de(?:l| la) (.+) ["'](.+)['"]$/ => lambda {|captures|
      if model = captures[0].to_model
        MundoPepino.world.send "#{model.name.underscore}_path", model.find_by_name(captures[1])
      end
    }
  }
end

Before do
  MundoPepino.clean_models
end

module MundoPepino
  include FixtureReplacement
end
