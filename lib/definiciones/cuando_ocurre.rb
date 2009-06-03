pagina_re = '(?:p[áa]gina|portada|[íi]ndice|listado|colecci[óo]n)'
Cuando /^(?:que )?visito (?:el|la) #{pagina_re} de ([\w]+|['"][\w ]+["'])$/i do |modelo_en_crudo|
  modelo = modelo_en_crudo.to_unquoted
  if model = modelo.to_model
    pile_up model.new
    do_visit eval("#{model.table_name}_path")
  elsif url = "la página de #{modelo_en_crudo}".to_url
    do_visit url
  else
    raise MundoPepino::ModelNotMapped.new(modelo)
  end
end

Cuando /^(?:que )?visito (?:el|la) #{pagina_re} del (.+) ['"](.+)["']$/i do |modelo, nombre|
  if resource = last_mentioned_of(modelo, nombre)
    do_visit eval("#{resource.class.name.underscore}_path(resource)")
  else
    raise MundoPepino::ModelNotMapped.new(modelo)
  end
end

Cuando /^(?:que )?visito la p[áa]gina de ([\w\/]+) (?:de )?(.+)$/i do |accion, modelo|
  model = modelo.to_unquoted.to_model or raise(MundoPepino::ModelNotMapped.new(modelo))
  action = accion.to_crud_action or raise(MundoPepino::CrudActionNotMapped.new(accion))
  pile_up model.new
  do_visit eval("#{action}_#{model.name.downcase}_path")
end

Cuando /^(?:que )?visito su (?:p[áa]gina|portada)$/i do
  do_visit last_mentioned_url
end

negative_lookahead = '(?:la|el) \w+ del? |su p[aá]gina|su portada'
Cuando /^(?:que )?visito (?!#{negative_lookahead})(.+)$/i do |pagina|
  do_visit pagina.to_unquoted.to_url
end

Cuando /^(?:que )?(?:pulso|pincho) (?:en )?el bot[oó]n (.+)$/i do |boton|
  click_button(boton.to_unquoted.to_translated)
end

Cuando /^(?:que )?(?:pulso|pincho) (?:en )?el (enlace|enlace ajax|enlace con efectos) (.+)$/i do |tipo, enlace|
  options = {}
  options[:wait] = case tipo.downcase
  when 'enlace con efectos' then :effects
  when 'enlace ajax' then :ajax
  else :page
  end
  click_link(enlace.to_unquoted.to_translated, options)
end

Cuando /^(?:que )?(?:completo|relleno) (.+) con (?:el valor )?['"](.+)["']$/i do |campo, valor|
  find_field_and_do_with_webrat :fill_in, campo, :with => valor
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

Cuando /^(?:que )?selecciono ["']([^"']+?)["'](?: en (?:el listado de )?(.+))?$/i do |valor, campo|
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

