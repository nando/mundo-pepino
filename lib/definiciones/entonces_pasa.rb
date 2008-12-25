module Cucumber::StepMethods
  alias_method :Entonces, :Then
end

Entonces /^(veo|no veo|debo ver|no debo ver) el texto (.+)?$/i do |should, text|
  eval('response.body.send(shouldify(should))') =~ /#{unquote(text)}/m
end

Entonces /^(veo|no veo|debo ver|no debo ver) (?:en )?(?:la etiqueta|el tag) ([^ ]+)(?:(?: con)? el valor )?["']?([^"']+)?["']?$/ do |should, tag, value |
  if value
    response.body.send(shouldify(should), have_tag(tag, value))
  else
    response.body.send(shouldify(should), have_tag(tag))
  end
end

Entonces /^(veo|no veo|debo ver|no debo ver) marcad[ao] (?:la casilla|el checkbox)? ?(.+)$/ do |should, campo|
  field_labeled(unquote(campo)).send shouldify(should), be_checked
end


#BBDD

Entonces /^(?:en (?:la )?(?:bb?dd?|base de datos) tenemos|tenemos en (?:la )?(?:bb?dd?|base de datos)) (un|una|dos|tres|cuatro|cinco|\d+) ([^ ]+)(?: (?:llamad[oa] )?['"](.+)["'])?$/ do |numero, modelo, nombre|
  model = modelo.to_model
  conditions = if nombre
    {:conditions => [ field_for(model, 'nombre') + '=?', nombre ]}
  else
    :all
  end
  model.count(conditions).should == numero.to_number
end

Entonces /^(?:el|la) (.+) "(.+)" (?:tiene en bbdd|en bbdd tiene) como (.+) "(.+)"(?: \w+)?$/ do |modelo, nombre, campo, valor|
  add_resource_from_database(modelo, nombre)
  last_resource_should_have_value(campo, valor)
end

Entonces /^(?:tiene en bbdd|en bbdd tiene) como (.+) "(.+)"(?: \w+)?$/ do |campo, valor|
  last_resource_should_have_value(campo, valor)
end

Entonces /^(?:el|la) (.+) "(.+)" (?:tiene en bbdd|en bbdd tiene) una? (.+) "(.+)"$/ do |padre, nombre_del_padre, hijo, nombre_del_hijo|
  add_resource_from_database(padre, nombre_del_padre)
  last_resource_should_have_child(hijo, nombre_del_hijo)
end

Entonces /^(?:tiene en bbdd|en bbdd tiene) una? (.+) "(.+)"$/ do |hijo, nombre_del_hijo|
  last_resource_should_have_child(hijo, nombre_del_hijo)
end
