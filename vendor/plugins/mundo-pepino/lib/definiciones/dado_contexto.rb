module Cucumber::StepMethods
  alias_method :Dado, :Given
end

Dado /^que hay (un|una|\d+) ([^ ]+)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |numero, modelo, nombre|
#  raise Cucumber::Pending.new("I need to implement this asap")
  numero.to_number.times do 
    add_resource(modelo.to_model)
  end
end
