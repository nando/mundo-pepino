module Cucumber::StepMethods
  alias_method :Dado, :Given
end

Dado /^que hay (un|una|\d+) ([^ ]+)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |numero, modelo, nombre|
  attributes = nombre ? { ('nombre'.to_field || 'name') => nombre } : {}
  numero.to_number.times do 
    add_resource(modelo.to_model, attributes)
  end
end
