module Cucumber::StepMethods
  alias_method :Dado, :Given
end

Dado /^que hay (un|una|\d+) ([^ ]+)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |numero, modelo, nombre|
  number = numero.to_number
  attribs = if nombre
    field = ('nombre'.to_field || 'name')
    names = nombre.split(/ ?, | y /)
    if names.size == number
      names.map { |name| { field => name } }
    else
      [{ field => nombre }] * number
    end
  else
    [{}] * number
  end
  attribs.each { |hash| add_resource(modelo.to_model, hash) }
end
