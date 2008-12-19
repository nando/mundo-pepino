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
  add_resource(model, attribs, :force_creation => true)
end

Dado /^(?:que tenemos )?(?:el|la|los|las) (?:siguientes? )?(.+):$/ do |modelo, tabla|
  model = unquote(modelo).to_model
  add_resource model, translated_hashes(tabla.raw), :force_creation => true
end 

Dado /^que dichos? (.+) tienen? como (.+) ['"](.+)["'](?:.+)?$/i do |modelo, campo, valor|
  if resource = last_resource_of(modelo)
    resources, values = resources_and_their_values(resource, valor)
    field,     values = field_and_values(modelo, campo, values)
    if field
      resources.each_with_index do |r, i| 
        r.update_attribute field, values[i] 
      end
    else
      raise MundoPepino::FieldNotMapped.new(campo)
    end
  end
end

Dado /^que dicho (.+) tiene (?:el|la|los|las) siguientes? (.+):$/i do |modelo_padre, modelo_hijos, tabla|
  if resource = last_resource_of(modelo_padre)
    children_model = unquote(modelo_hijos).to_model
    add_resource children_model, translated_hashes(tabla.raw, :parent => resource)
  end
end
