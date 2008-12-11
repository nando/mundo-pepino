require 'string-mapper'
require 'definiciones/dado_contexto'
require 'definiciones/cuando_ocurre'
require 'definiciones/entonces_pasa'

String.add_mapper :model
String.add_mapper :field
String.add_mapper(:url, 
  /la (portada|home)/i => '/') { |string| string }
String.add_mapper(:number, { 
  /una?/i => 1,
  :dos    => 2,
  :tres   => 3,
  :cuatro => 4 }) { |string| string.to_i }

class MundoPepino < Cucumber::Rails::World
  include FixtureReplacement

  def factory(model_or_modelo, attributes = {})
    model = if model_or_modelo.is_a?(String)
      model_or_modelo.to_model
    else
      model_or_modelo
    end
    self.send "create_#{model.name.downcase}", attributes
  end

  def add_resource(resource, attributes={})
    @resources ||= []
    @resources << factory(resource, attributes)
  end


  def shouldify(should_or_not)
    should_or_not.downcase == 'debo' ? :should : :should_not
  end

  def not_shouldify(should_or_not)
    shouldify(should_or_not) == :should ? :should_not : :should
  end

  def unquote(string_or_array)
    if string_or_array.is_a?(Array)
      string_or_array.map { |str| unquote(str) }
    else
      string_or_array =~ /^['"](.*)['"]$/ ? $1 : string_or_array
    end
  end
  
end
