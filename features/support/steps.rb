Then /^existen? (un|una|dos|tres|cuatro|cinco|\d+) ([^ ]+)(?: ['"](.+)["'])?$/ do |numero, modelo, nombre|
  model = modelo.to_model
  conditions = if nombre
    {:conditions => [ field_for(model, 'nombre') + '=?', nombre ]}
  else
    :all
  end
  model.count(conditions).should == numero.to_number
end

Then /^como (.+) "(.+)"(?: \w+)?$/ do |campo, valor|
  entonces_campo_valor(campo, valor)
end

Then /^(?:el|la) (.+) "(.+)" tiene como (.+) "(.+)"$/ do |modelo, nombre, campo, valor|
  @then_resource = modelo.to_model.find_by_name(nombre)
  entonces_campo_valor(campo, valor)
end

Then /^(?:el|la) (.+) "(.+)" tiene una? (.+) "(.+)"$/ do |padre, nombre_del_padre, hijo, nombre_del_hijo|
  @then_resource = padre.to_model.find_by_name(nombre_del_padre)
  entonces_tiene_hijo(hijo, nombre_del_hijo)
end
