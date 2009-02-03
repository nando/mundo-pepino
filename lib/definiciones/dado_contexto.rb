numero = 'un|una|dos|tres|cuatro|cinco|\d+'
cuyo = '(?:cuy[oa]s?|que tienen? como)'
# Creación simple con nombre opcional
Dado /^(?:que tenemos )?(#{numero}) (?!.+ #{cuyo})(.+?)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |numero, modelo, nombre|
  if model = modelo.to_unquoted.to_model
    number = numero.to_number
    attribs = names_for_simple_creation(model, number, nombre)
    add_resource(model, attribs, :force_creation => true)
  else
    raise MundoPepino::ModelNotMapped.new(modelo)
  end
end
# Creación con asignación de valor en campo
Dado /^(?:que tenemos )?(#{numero}) (.+) #{cuyo} (.+?) (?:(?:es|son) (?:de )?)?['"](.+)["'](?: .+)?$/i do |numero, modelo, campo, valor|
  Dado "que tenemos #{numero} #{modelo}"
  Dado "que dichos #{modelo} tienen como #{campo} '#{valor}'"
end

Dado /^(?:que tenemos )?(?:el|la|los|las|el\/la|los\/las) (?:siguientes? )?(.+):$/ do |modelo, tabla|
  model = unquote(modelo).to_model
  add_resource model, translated_hashes(tabla.raw, :model => model), :force_creation => true
end 

Dado /^que (?:el|la) (.+) ['"](.+)["'] tiene como (.+) ['"](.+)["'](?: \w+)?$/ do |modelo, nombre, campo, valor|
  if resource = last_mentioned_of(modelo, nombre)
    if field = field_for(resource.class, campo)
      resource.update_attribute field, valor
      pile_up resource
    else
      raise MundoPepino::FieldNotMapped.new(campo)
    end
  end
end

Dado /^que dich[oa]s? (.+) tienen? como (.+) ['"](.+)["'](?:.+)?$/i do |modelo, campo, valor|
  if res = last_mentioned_of(modelo)
    resources, field, values = resources_array_field_and_values(res, campo, valor)
    if field
      resources.each_with_index do |r, i| 
        r.update_attribute field, values[i] 
      end
    else
      raise MundoPepino::FieldNotMapped.new(campo)
    end
  end
end

Dado /^que dich[oa] (.+) tiene (un|una|dos|tres|cuatro|cinco|\d+) (.+?)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |modelo_padre, numero, modelo_hijos, nombres|
  if resource = last_mentioned_of(modelo_padre.to_unquoted)
    children_model = modelo_hijos.to_unquoted.to_model
    attribs = names_for_simple_creation(children_model, 
      numero.to_number, nombres, :parent => resource)
    add_resource children_model, attribs, :force_creation => nombres.nil?
  end
end

Dado /^que dicho (.+) tiene (?:el|la|los|las) siguientes? (.+):$/i do |modelo_padre, modelo_hijos, tabla|
  if resource = last_mentioned_of(modelo_padre.to_unquoted)
    children_model = modelo_hijos.to_unquoted.to_model
    add_resource children_model, 
      translated_hashes(tabla.raw, {:model => children_model, :parent => resource})
  end
end
