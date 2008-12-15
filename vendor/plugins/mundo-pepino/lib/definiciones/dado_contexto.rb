module Cucumber::StepMethods
  alias_method :Dado, :Given
end

Dado /^que hay ([^ ]+) ([^ ]+)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |numero, modelo, nombre|
  number = numero.to_number
  model = modelo.to_model
  attribs = if nombre
    field = name_field_for(modelo)
    names = nombre.split(/ ?, | y /)
    if names.size == number
      names.map { |name| { field => name } }
    else
      [{ field => nombre }] * number
    end
  else
    [{}] * number
  end
  add_resource(model, attribs)
end

Dado /^que dichos? (.+) tienen? como (.+) ['"](.+)["'](?:.+)?$/i do |modelo, campo, valor|
  if resource = last_resource_of(modelo)
    values = if resource.is_a?(Array)
      valores = valor.split(/ ?, | y /)
      if valores.size == resource.size
        valores
      else
        [ valor ] * resource.size
      end
    else
      resource = [ resource ]
      [ valor ]
    end
    field = if (child_model = campo.to_model)
      child_name_field = name_field_for(modelo)
      values = add_resource(child_model, 
        values.map { |val| { child_name_field => val } })
      values = [ values ] unless values.is_a?(Array)
      child_model.name.downcase
    else 
      campo.to_field
    end
    if field
      resource.each_with_index do |r, i| 
        r.update_attribute field, values[i] 
      end
    else
      raise MundoPepino::FieldNotMapped.new(campo)
    end
  end
end
