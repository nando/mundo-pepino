# encoding: UTF-8 
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
    Sprinkler,
    Flower,
    Session, 
    Delivery, 
    User,
    Profile
  ]
  config.model_mappings = {
    /^sesi[óo]n$/i              => Session,
    /^huert[oa]s?$/i            => Orchard,
    /^bancal(es)?$/i            => Terrace,
    /^cultivos?$/i              => Crop,
    /^(abono|fertilizante)s?$/i => Fertilizer,
    /^tomates?$/i               => Tomato,
    /^acelgas?$/i               => Chard,
    /^pepinos?$/i               => Pepino,
    /^aspersor(es)?$/i          => Sprinkler,
    /^lechugas?$/i              => Lettuce,
    /^huerto de nacimiento$/i   => Orchard,
    /^flor(?:es)?(?: enviadas?)?$/i => Flower,
    /^sesión(es)?$/i            => Session,
    /^remitentes?$/i            => User,
    /^usuari[ao]s?$/i           => User,
    /^env[ií]os?$/i             => Delivery,
    /^perfil(es)?$/i            => Profile,
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
    /^Pepino::nombre$/i          => :title,
    /^pepinos?$/i                => :cucumbers,
    /^títulos?$/i                => :title,
    /^(?:clave|contraseña)s?$/i  => :password, 
    /^flor(?:es)? enviadas?$/i   => :sended_flowers,
    /^Flower::remitentes?$/i     => :from,
    /^Flower::flor(?:es)? enviadas?$/i => :from,
    /^Flower::name$/i            => :title,
    /^User::perfil$/i            => :profile,
    /^Profile::name$/i           => :first_name
  }
  config.relation_model_mappings = {
    /^cucumbers$/        => Pepino,
    /^orchard_of_birth$/ => Orchard,
    /^from$/             => User
  }
  config.url_mappings = {
    /^la página de registro/i => lambda {
      MundoPepino.world.url_for(:only_path=>true,
        :controller=>'welcome', :action => 'signup')
    },
    /^la página de (?:identificación|login)/i => lambda {
      MundoPepino.world.new_session_path
    },
    # Para testear que tienen prioridad estos mapeos que
    # la interpretación que MP hace de la expresión
    /^la página de creación de lechugas$/ => lambda { MundoPepino.world.root_path }
  }
end

Before do
  MundoPepino.clean_models
end

module MundoPepino
  include FixtureReplacement
end

Dado /^que inicio sesión con (?:el|la) usuari[oa] (.+)$/ do |usuario|
  user = last_mentioned_of("usuario", usuario.to_unquoted)
  Dado 'que visito la página de inicio de sesión'
  Cuando 'relleno nombre con "'+user.name+'"'
       Y 'relleno contraseña con "'+user.password+'"'
       Y 'pulso el botón "Entrar"'
end
