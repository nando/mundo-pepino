# MundoPepino's step definitions in es_ES
Dado /^que estoy en (?!#{_pagina_desde_rutas_})(.+)$/ do |pagina|
  do_visit pagina.to_unquoted.to_url
end 

# Creación simple con nombre opcional
Dado /^(?:que tenemos )?(#{_numero_}) (?!.+ #{_cuyo_})(.+?)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |numero, modelo, nombre|
  given_we_have_a_number_of_instances_called numero, modelo, nombre 
end

# Creación con asignación de valor en campo
Dado /^(?:que tenemos )?(#{_numero_}) (.+) #{_cuyo_} (.+?) (?:(?:es|son) (?:de )?)?['"](.+)["'](?: .+)?$/i do |numero, modelo, campo, valor|
  Dado "que tenemos #{numero} #{modelo}"
  Dado "que dichos #{modelo} tienen como #{campo} '#{valor}'"
end

Dado /^(?:que tenemos )?(?:el|la|los|las|el\/la|los\/las) (?:siguientes? )?(.+):$/ do |modelo, tabla|
  model = modelo.to_unquoted.to_model
  add_resource model, translated_hashes(tabla.raw, :model => model), :force_creation => true
end 

Dado /^que (?:el|la) (.+) ['"](.+)["'] tiene como (.+) ['"](.+)["'](?: \w+)?$/ do |modelo, nombre, campo, valor|
  if resource = last_mentioned_of(modelo, nombre)
    if field = field_for(resource.class, campo)
      resource.update_attribute field, real_value_for(valor)
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
        r.update_attribute field, real_value_for(values[i])
      end
      pile_up res
    else
      raise MundoPepino::FieldNotMapped.new(campo)
    end
  end
end

Dado /^que (?:el|la) (.+) ['"](.+)["'] tiene (#{_numero_}) (.+?)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |modelo_padre, nombre_del_padre, numero, modelo_hijos, nombres|
  given_resource_has_many_children(
    :resource_model => modelo_padre,
    :resource_name => nombre_del_padre,
    :number_of_children => numero,
    :children_model => modelo_hijos,
    :children_names => nombres)
end

Dado /^que dich[oa]s? (.+) tienen? (#{_numero_}) (.+?)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |modelo_padre, numero, modelo_hijos, nombres|
  given_resource_has_many_children(
    :resource_model => modelo_padre,
    :number_of_children => numero,
    :children_model => modelo_hijos,
    :children_names => nombres)
end

Dado /^que (?:el|la) (.+) ['"](.+)["'] tiene (?:el|la|los|las) siguientes? (.+):$/i do |modelo_padre, nombre_del_padre, modelo_hijos, tabla|
  given_resource_has_many_children_from_step_table(
    :resource_model => modelo_padre,
    :resource_name  => nombre_del_padre,
    :children_model => modelo_hijos,
    :step_table => tabla)
end

Dado /^que dich[ao]s? (.+) tienen? (?:el|la|los|las) siguientes? (.+):$/i do |modelo_padre, modelo_hijos, tabla|
  given_resource_has_many_children_from_step_table(
    :resource_model => modelo_padre,
    :children_model => modelo_hijos,
    :step_table => tabla)
end


###############################################################################

Cuando /^(?:que )?visito ((?:el|la) #{_pagina_} de )([\w]+|['"][\w ]+["'])$/i do |la_pagina_de, modelo_en_crudo|
  do_visit resource_index_or_mapped_page(la_pagina_de, modelo_en_crudo)
end

Cuando /^(?:que )?visito (?:el|la) #{_pagina_} (?:del|de la) (.+) ['"](.+)["']$/i do |modelo, nombre|
  if resource = last_mentioned_of(modelo, nombre)
    do_visit send("#{resource.class.name.underscore}_path", resource)
  else
    raise MundoPepino::ResourceNotFound.new("model #{modelo}, name #{nombre}")
  end
end

Cuando /^(?:que )?visito la p[áa]gina de (?!la)([\w\/]+) (?:de |de la |del )?(.+?)(?: (['"].+["']))?$/i do |accion, modelo, nombre|
  action = accion.to_crud_action or raise(MundoPepino::CrudActionNotMapped.new(accion))
  if action != 'new'
    nombre, modelo = modelo, nil unless nombre
    resource = if modelo && modelo.to_unquoted.to_model
      last_mentioned_of(modelo, nombre.to_unquoted)
    else
      last_mentioned_called(nombre.to_unquoted)
    end
    if resource
      do_visit send("#{action}_#{resource.mr_singular}_path", resource)
    else
      MundoPepino::ResourceNotFound.new("model #{modelo}, name #{nombre}")
    end
  else
    model = modelo.to_unquoted.to_model or raise(MundoPepino::ModelNotMapped.new(modelo))
    pile_up model.new
    do_visit send("#{action}_#{model.name.underscore}_path")
  end
end

Cuando /^(?:que )?visito su (?:p[áa]gina|portada)$/i do
  do_visit last_mentioned_url
end

Cuando /^(?:que )?visito (?!#{_pagina_desde_rutas_})(.+)$/i do |pagina|
  given_or_when_i_do_a_page_request pagina
end

Cuando /^(?:que )?#{_pulso_} (?:en )?el bot[oó]n (.+)$/i do |boton|
  click_button(boton.to_unquoted.to_translated)
end

Cuando /^(?:que )?#{_pulso_} (?:en )?el (enlace|enlace ajax|enlace con efectos) (.+)$/i do |tipo, enlace|
  options = {}
  options[:wait] = case tipo.downcase
  when 'enlace con efectos' then :effects
  when 'enlace ajax' then :ajax
  else :page
  end
  click_link(enlace.to_unquoted.to_translated, options)
end

Cuando /^(?:que )?#{_pulso_} (?:en )?los (?:siguientes )?(?:enlaces|botones)(?: y (?:enlaces|botones))?:$/i do |tabla|
  tabla.raw.each_with_index do |row, index|
    if row.size == 1
      Cuando "pulso el enlace '#{row[0]}'"
    else
      next if index == 0
      if row[0] =~ /enlace/i
        Cuando "pulso el enlace '#{row[1]}'"
      else
        Cuando "pulso el botón '#{row[1]}'"
      end
    end
  end
end

Cuando /^(?:que )?(?:completo|relleno) (?!#{_localizador_de_atributo_anidado_(false)})(.+) con (?:el valor )?['"](.+)["']$/i do |campo, valor|
  find_field_and_do_with_webrat :fill_in, campo, :with => valor
end

Cuando /^(?:que )?(?:completo|relleno):$/i do |tabla|
  tabla.raw[1..-1].each do |row|
    Cuando "relleno \"#{row[0].gsub('"', '\"')}\" con \"#{row[1].gsub('"', '\"')}\""
  end
end

Cuando /^(?:que )?(?:completo|relleno) #{_localizador_de_atributo_anidado_} con (?:el valor )?['"](.+)["']$/i do |campo, modelo_anidado, nombre_anidado, valor|
  field_id = nested_field_id(campo, modelo_anidado, nombre_anidado, last_mentioned)
  find_field_and_do_with_webrat :fill_in, field_id, :with => valor
end

Cuando /^(?:que )?elijo (?:la|el)? ?(.+) ['"](.+)["']$/i do |campo, valor|
  choose(campo_to_field(campo).to_s + '_' + valor.downcase.to_underscored)
end

Cuando /^(?:que )?marco (?:la|el)? ?(.+)$/i do |campo|
  find_field_and_do_with_webrat :check, campo
end

Cuando /^(?:que )?desmarco (?:la|el)? ?(.+)$/i do |campo|
  find_field_and_do_with_webrat :uncheck, campo
end

Cuando /^(?:que )?adjunto el fichero ['"](.*)["'] (?:a|en) (.*)$/ do |ruta, campo|
  find_field_and_do_with_webrat :attach_file, campo, 
    {:path => ruta, :content_type => ruta.to_content_type}
end

Cuando /^(?:que )?selecciono ["']([^"']+?)["'](?: (?:en (?:el listado de )?|como )(?!#{_fecha_y_o_hora_})(.+))?$/i do |valor, campo|
  begin
    if campo
      select valor, :from => campo.to_unquoted.to_translated  # Vía label
    else
      select valor
    end
  rescue Webrat::NotFoundError
    select(valor, :from => campo_to_field(campo)) # Sin label
  end
end

Cuando /^(?:que )?selecciono ['"]?(\d\d?) de (\w+) de (\d{4}), (\d\d?:\d\d)["']? como fecha y hora(?: (?:de )?['"]?(.+?)["']?)?$/ do |dia, mes, anio, hora, etiqueta|
# Cuando selecciono "25 de diciembre de 2008, 10:00" como fecha y hora
# Cuando selecciono 23 de noviembre de 2004, 11:20 como fecha y hora "Preferida"
# Cuando selecciono 23 de noviembre de 2004, 11:20 como fecha y hora de "Publicación"
  time = Time.parse("#{mes.to_month} #{dia}, #{anio} #{hora}")
  options = etiqueta ? { :from => etiqueta } : {}
  select_datetime(time, options)
end

Cuando /^(?:que )?selecciono ['"]?(.*)["']? como (?:la )?hora(?: (?:(?:del?|para) (?:la |el )?)?['"]?(.+?)["']?)?$/ do |hora, etiqueta|
  options = etiqueta ? { :from => etiqueta } : {}
  select_time(hora, options)
end

Cuando /^(?:que )?selecciono ['"]?(\d\d?) de (\w+) de (\d{4})["']? como (?:la )?fecha(?: (?:(?:del?|para) (?:la |el )?)?['"]?(.+?)["']?)?$/ do |dia, mes, anio, etiqueta|
  time = Time.parse("#{mes.to_month} #{dia}, #{anio} 12:00")
  options = etiqueta ? { :from => etiqueta } : {}
  select_date(time, options)
end

Cuando /^borro (?:el|la|el\/la) (.+) en (?:la )?(\w+|\d+)(?:ª|º)? posición$/ do |modelo, posicion|
  pile_up modelo.to_unquoted.to_model.new
  do_visit last_mentioned_url
  within("table > tr:nth-child(#{posicion.to_number+1})") do
    click_link "Borrar"
  end
end

#############################################################################
Entonces /^(#{_veo_o_no_}) el texto (.+?)(?: dentro de(?: la etiqueta|l selector)? ['"]?(.+?)["']?)?$/i do |should, text, selector|
  then_i_see_or_not_the_text should, text, selector
end

Entonces /^(#{_leo_o_no_}) el texto (.+)?$/i do |should, text|
  begin
    HTML::FullSanitizer.new.sanitize(response.body).send(shouldify(should)) =~ /#{Regexp.escape(text.to_unquoted.to_translated)}/m
  rescue Spec::Expectations::ExpectationNotMetError
    webrat.save_and_open_page
    raise
  end
end

Entonces /^(#{_veo_o_no_}) los siguientes textos:$/i do |should, texts|
  texts.raw.each do |row|
    Entonces "#{should} el texto #{row[0]}"
  end
end

Entonces /^(#{_leo_o_no_}) los siguientes textos:$/i do |should, texts|
  texts.raw.each do |row|
    Entonces "#{should} el texto #{row[0]}"
  end
end

Entonces /^(#{_veo_o_no_}) (?:en )?(?:el selector|la etiqueta|el tag) (["'].+?['"]|[^ ]+)(?:(?: con)? el (?:valor|texto) )?["']?([^"']+)?["']?$/ do |should, tag, value |
  lambda {
    if value
      response.should have_tag(tag.to_unquoted, /.*#{value.to_translated}.*/i)
    else
      response.should have_tag(tag.to_unquoted)
    end
  }.send(not_shouldify(should), raise_error)  
end

Entonces /^(#{_veo_o_no_}) (?:las|los) siguientes (?:etiquetas|selectores):$/i do |should, texts|
  check_contents, from_index = texts.raw[0].size == 2 ? [true, 1] : [false, 0]
  texts.raw[from_index..-1].each do |row|
    if check_contents
      Entonces "#{should} el selector \"#{row[0]}\" con el valor \"#{row[1]}\""
    else
      Entonces "#{should} el selector \"#{row[0]}\""
    end
  end
end

Entonces /^(#{_veo_o_no_}) un enlace (?:al?|para) (.+)?$/i do |should, pagina|
  lambda {
    href = relative_page(pagina) || pagina.to_unquoted.to_url 
    response.should have_tag('a[href=?]', href)
  }.send(not_shouldify(should), raise_error)
end

Entonces /^(#{_veo_o_no_}) el campo (.+) con el (?:valor|texto)? (.+)$/ do |should, campo, valor|
  field_labeled(campo.to_unquoted).value.send shouldify(should), match(/#{valor.to_unquoted}/)
end

Entonces /^(#{_veo_o_no_}) marcad[ao] (?:la casilla|el checkbox)? ?(.+)$/ do |should, campo|
  field_labeled(campo.to_unquoted).send shouldify(should), be_checked
end

Entonces /^(#{_veo_o_no_}) (?:una|la) tabla (?:(["'].+?['"]|[^ ]+) )?con (?:el|los) (?:siguientes? )?(?:valore?s?|contenidos?):$/ do |should, table_id, valores|
  table_id = "##{table_id.to_unquoted}" if table_id
  shouldified = shouldify(should)
  response.send shouldified, have_selector("table#{table_id}")

  if have_selector("table#{table_id} tbody").matches?(response)
    start_row = 1
    tbody = "tbody"
  else
    start_row = 2
    tbody = ""
  end

  valores.raw[1..-1].each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.send shouldified, 
      have_selector("table#{table_id} #{tbody} tr:nth-child(#{i+start_row})>td:nth-child(#{j+1})") { |td|
        td.inner_text.should =~ /#{cell == '.*' ? cell : Regexp.escape((cell||"").to_translated)}/
      }
    end
  end
end

Entonces /^(#{_veo_o_no_}) un formulario con (?:el|los) (?:siguientes? )?(?:campos?|elementos?):$/ do |should, elementos|
  shouldified = shouldify(should)
  response.send(shouldified, have_tag('form')) do
    elementos.raw[1..-1].each do |row|
      label, type = row[0].to_translated, row[1]
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
          field_labeled(label).element.attributes['type'].to_s.should == type
      end
    end
  end
end

#BBDD
Entonces /^#{_tenemos_en_bbdd_} (#{_numero_}) ([^ ]+)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/ do |numero, modelo, nombre|
  then_we_have_a_number_of_instances_in_our_database numero, modelo, nombre
end

Entonces /^(?:el|la) (.+) "(.+)" #{_tiene_en_bbdd_} como (.+) "(.+)"(?: \w+)?$/ do |modelo, nombre, campo, valor|
  add_resource_from_database(modelo, nombre)
  last_mentioned_should_have_value(campo, valor.to_real_value)
end

Entonces /^#{_tiene_en_bbdd_} como (.+) "(.+)"(?: \w+)?$/ do |campo, valor|
  last_mentioned_should_have_value(campo, valor.to_real_value)
end

Entonces /^(?:el|la) (.+) "(.+)" #{_tiene_en_bbdd_} una? (.+) "(.+)"$/ do |padre, nombre_del_padre, hijo, nombre_del_hijo|
  add_resource_from_database(padre, nombre_del_padre)
  last_mentioned_should_have_child(hijo, nombre_del_hijo)
end

Entonces /^(?:el|la) (.+) "(.+)" #{_tiene_en_bbdd_} (#{_numero_}) ['"]?([^"']+)["']?$/ do |modelo_padre, nombre_del_padre, numero, modelo_hijo|
  add_resource_from_database(modelo_padre, nombre_del_padre)
  last_mentioned_should_have_n_children(modelo_hijo, numero)
end

Entonces /^#{_tiene_en_bbdd_} una? (.+) "(.+)"$/ do |hijo, nombre_del_hijo|
  last_mentioned_should_have_child(hijo, nombre_del_hijo)
end

Entonces /^#{_tiene_en_bbdd_} (#{_numero_}) ['"]?([^"']+)["']?$/ do |numero, modelo_hijo|
  last_mentioned_should_have_n_children(modelo_hijo, numero)
end

Entonces /^#{_debo_estar_en_} ((?:el|la) #{_pagina_} de )([\w\s]+|['"][\w ]+["'])$/i do |la_pagina_de, modelo_en_crudo|
  URI.parse(current_url).path.should == resource_index_or_mapped_page(la_pagina_de, modelo_en_crudo)
end

Entonces /^#{_debo_estar_en_} (?!#{_pagina_desde_rutas_})(.+)$/i do |pagina|
  URI.parse(current_url).path.should == pagina.to_unquoted.to_url
end
