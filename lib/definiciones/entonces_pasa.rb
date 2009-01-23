module Cucumber::StepMethods
  alias_method :Entonces, :Then
end

veo_o_no = '(?:no )?(?:veo|debo ver|debería ver)'

Entonces /^(#{veo_o_no}) el texto (.+)?$/i do |should, text|
  eval('response.body.send(shouldify(should))') =~ /#{unquote(text)}/m
end

Entonces /^(#{veo_o_no}) (?:en )?(?:la etiqueta|el tag) ([^ ]+)(?:(?: con)? el valor )?["']?([^"']+)?["']?$/ do |should, tag, value |
  if value
    response.body.send(shouldify(should), have_tag(tag, value))
  else
    response.body.send(shouldify(should), have_tag(tag))
  end
end

Entonces /^(#{veo_o_no}) marcad[ao] (?:la casilla|el checkbox)? ?(.+)$/ do |should, campo|
  field_labeled(unquote(campo)).send shouldify(should), be_checked
end

Entonces /^(#{veo_o_no}) una tabla con (?:el|los) (?:siguientes? )?(?:valore?s?|contenidos?):$/ do |should, valores|
  shouldified = shouldify(should)
  valores.raw[1..-1].each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.send shouldified, 
        have_selector("table > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") { |td|
          td.inner_text.should == cell
        }
    end
  end
end

Entonces /^(#{veo_o_no}) un formulario con (?:el|los) (?:siguientes? )?(?:campos?|elementos?):$/ do |should, elementos|
  shouldified = shouldify(should)
  response.send(shouldified, have_tag('form')) do
    elementos.raw[1..-1].each do |row|
      label, type = row
      case type
        when "submit":
          with_tag "input[type='submit'][value='#{label}']"
        when "radio":
          with_tag('div') do
            with_tag "label", label
            with_tag "input[type='radio']"
          end  
        when "select", "textarea":
          field_labeled(label).element.name.should == type
        else  
          field_labeled(label).element.attributes['type'].should == type
      end
    end
  end
end

#BBDD
en_bbdd_tenemos = '(?:en (?:la )?(?:bb?dd?|base de datos) tenemos|tenemos en (?:la )?(?:bb?dd?|base de datos))'
tiene_en_bbdd = '(?:tiene en (?:la )?bbdd|en (?:la )?bbdd tiene|tiene en (?:la )?base de datos|en (?:la )?base de datos tiene)'
Entonces /^#{en_bbdd_tenemos} (un|una|dos|tres|cuatro|cinco|\d+) ([^ ]+)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/ do |numero, modelo, nombre|
  model = modelo.to_unquoted.to_model
  conditions = if nombre
    {:conditions => [ "#{field_for(model, 'nombre')}=?", nombre ]}
  else
    {}
  end
  resources = model.find(:all, conditions)
  resources.size.should == numero.to_number
  if resources.size > 0
    pile_up (resources.size == 1 ? resources.first : resources)
  end
end

Entonces /^(?:el|la) (.+) "(.+)" #{tiene_en_bbdd} como (.+) "(.+)"(?: \w+)?$/ do |modelo, nombre, campo, valor|
  add_resource_from_database(modelo, nombre)
  last_mentioned_should_have_value(campo, valor)
end

Entonces /^#{tiene_en_bbdd} como (.+) "(.+)"(?: \w+)?$/ do |campo, valor|
  last_mentioned_should_have_value(campo, valor)
end

Entonces /^(?:el|la) (.+) "(.+)" #{tiene_en_bbdd} una? (.+) "(.+)"$/ do |padre, nombre_del_padre, hijo, nombre_del_hijo|
  add_resource_from_database(padre, nombre_del_padre)
  last_mentioned_should_have_child(hijo, nombre_del_hijo)
end

Entonces /^#{tiene_en_bbdd} una? (.+) "(.+)"$/ do |hijo, nombre_del_hijo|
  last_mentioned_should_have_child(hijo, nombre_del_hijo)
end
