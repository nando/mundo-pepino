require 'string_mappings'
require 'definiciones/dado_contexto'

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
end
