# MundoPepino's step definitions in es_ES
# Creación simple con nombre opcional
Dado /^(?:que tenemos )?(#{_numero_}) (?!.+ #{_cuyo_})(.+?)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |numero, modelo, nombre|
  given_we_have_a_number_of_instances_called(
    :number => numero,
    :model => modelo,
    :name => nombre)
end

# Creación con asignación de valor en campo
Dado /^(?:que tenemos )?(#{_numero_}) (.+) #{_cuyo_} (.+?) (?:(?:es|son) (?:de )?)?['"](.+)["'](?: .+)?$/i do |numero, modelo, campo, valor|
  Dado "que tenemos #{numero} #{modelo}"
  Dado "que dichos #{modelo} tienen como #{campo} '#{valor}'"
end

Dado /^(?:que tenemos )?(?:el|la|los|las|el\/la|los\/las) (?:siguientes? )?(.+):$/ do |modelo, tabla|
  given_we_have_the_following_instances_from_step_table :model => modelo, :table => tabla
end 

Dado /^que (?:el|la) (.+) ['"](.+)["'] tiene como (.+) ['"](.+)["'](?: \w+)?$/ do |modelo, nombre, campo, valor|
  given_resource_has_value_in_field :model => modelo,
    :name => nombre,
    :field => campo,
    :value => valor
end

Dado /^que dich[oa]s? (.+) tienen? como (.+) ['"](.+)["'](?:.+)?$/i do |modelo, campo, valor|
  given_those_resources_have_value_in_field :model => modelo,
    :field => campo,
    :value => valor
end

Dado /^que (?:el|la) (.+) ['"](.+)["'] tiene (#{_numero_}) (.+?)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |modelo_padre, nombre_del_padre, numero, campo_hijos, nombres|
  given_resource_has_many_children(
    :model => modelo_padre,
    :name => nombre_del_padre,
    :number_of_children => numero,
    :children_field => campo_hijos,
    :children_names => nombres)
end

Dado /^que dich[oa]s? (.+) tienen? (#{_numero_}) (.+?)(?: (?:llamad[oa]s? )?['"](.+)["'])?$/i do |modelo_padre, numero, campo_hijos, nombres|
  given_resource_has_many_children(
    :model => modelo_padre,
    :number_of_children => numero,
    :children_field => campo_hijos,
    :children_names => nombres)
end

Dado /^que (?:el|la) (.+) ['"](.+)["'] tiene (?:el|la|los|las) siguientes? (.+):$/i do |modelo_padre, nombre_del_padre, campo_hijos, tabla|
  given_resource_has_many_children_from_step_table(
    :model => modelo_padre,
    :name  => nombre_del_padre,
    :children_field => campo_hijos,
    :step_table => tabla)
end

Dado /^que dich[ao]s? (.+) tienen? (?:el|la|los|las) siguientes? (.+):$/i do |modelo_padre, campo_hijos, tabla|
  given_resource_has_many_children_from_step_table(
    :model => modelo_padre,
    :children_field => campo_hijos,
    :step_table => tabla)
end


###############################################################################

Cuando /^(?:que )?#{_visito_} (.+)$/i do |pagina|
  given_or_when_i_do_a_page_request :page => pagina
end

Cuando /^(?:que )?#{_pulso_} (?:en )?el bot[oó]n (.+)$/i do |boton|
  click_button(boton.to_unquoted.to_translated)
end

Cuando /^(?:que )?#{_pulso_} (?:en )?(#{_el_enlace_}) (.+?)(?:#{_que_existe_} #{_dentro_de_} ['"]?(.+?)["']?)?$/i do |el_enlace, enlace, selector|
  if selector.nil? and 
     href = (enlace.to_url || "#{el_enlace} #{enlace}".to_url)
    Entonces "veo el enlace #{href}"
    Y "visito #{href}"
  else
    given_or_when_i_follow_the_link(
      :link => enlace.to_unquoted.to_translated,
      :selector => selector)
  end
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

Cuando /^(?:que )?(?:completo|relleno)(?: los(?: siguientes)? campos)?:$/i do |tabla|
  tabla.raw[1..-1].each do |row|
    Cuando "relleno \"#{row[0].gsub('"', '\"')}\" con \"#{row[1].gsub('"', '\"')}\""
  end
end

Cuando /^(?:que )?(?:completo|relleno) #{_localizador_de_atributo_anidado_} con (?:el valor )?['"](.+)["']$/i do |campo, modelo, nombre, valor|
  field_id = nested_field_id(last_mentioned, modelo, campo, nombre)
  find_field_and_do_with_webrat :fill_in, field_id, :with => valor
end

Cuando /^(?:que )?elijo (?:la|el)? ?(.+) ['"](.+)["']$/i do |campo, valor|
  choose(convert_to_field(campo).to_s + '_' + valor.downcase.to_underscored)
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
    select(valor, :from => convert_to_field(campo)) # Sin label
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
Entonces /^(#{_veo_o_no_}) el texto (.+?)(?: #{_dentro_de_} ['"]?(.+?)["']?)?$/i do |should, text, selector|
  then_i_see_or_not_the_text :should => should,
    :text => text,
    :selector => selector
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

Entonces /^(#{_veo_o_no_}) #{_la_etiqueta_} (["'].+?['"]|[^ ]+)(?:(?: con)? el (?:valor|texto) )?["']?([^"']+)?["']?$/ do |should, tag, value |
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

Entonces /^(#{_veo_o_no_}) (?:un|el) enlace (?:al? |para )?(.+)?$/i do |should, pagina|
  lambda {
    response.should have_tag('a[href=?]', pagina.to_unquoted.to_url)
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
  then_we_have_a_number_of_instances_in_our_database :number => numero,
    :model => modelo,
    :name => nombre
end

Entonces /^(?:el|la) (.+) ['"](.+)["'] #{_tiene_en_bbdd_} como (.+) ['"](.+)["'](?: \w+)?$/ do |modelo, nombre, campo, valor|
  then_resource_called_name_should_have_value_in_field :model => modelo,
    :name => nombre,
    :field => campo,
    :value => valor
end

Entonces /^#{_tiene_en_bbdd_} como (.+) ['"](.+)["'](?: \w+)?$/ do |campo, valor|
  then_that_resource_should_have_value_in_field :field => campo, :value => valor
end

Entonces /^(?:el|la) (.+) ['"](.+)["'] #{_tiene_en_bbdd_} una? (.+) ['"](.+)["']$/ do |padre, nombre_del_padre, hijo, nombre_del_hijo|
  add_resource_from_database(padre, nombre_del_padre)
  last_mentioned_should_have_child(hijo, nombre_del_hijo)
end

Entonces /^(?:el|la) (.+) "(.+)" #{_tiene_en_bbdd_} (#{_numero_}) ['"]?([^"']+)["']?$/ do |modelo, nombre, numero, relacion|
  then_resource_called_name_should_have_n_children :number => numero,
    :model => modelo,
    :name => nombre,
    :children_field => relacion
end

Entonces /^#{_tiene_en_bbdd_} una? (.+) ['"](.+)["']$/ do |hijo, nombre_del_hijo|
  last_mentioned_should_have_child(hijo, nombre_del_hijo)
end

Entonces /^#{_tiene_en_bbdd_} (#{_numero_}) ['"]?([^"']+)["']?$/ do |numero, modelo_hijo|
  last_mentioned_should_have_n_children(modelo_hijo, numero)
end

Entonces /^#{_debo_estar_en_} (.+)$/i do |pagina|
  URI.parse(current_url).path.should == pagina.to_unquoted.to_url
end
