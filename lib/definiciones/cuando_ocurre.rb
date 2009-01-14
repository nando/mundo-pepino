module Cucumber::StepMethods
  alias_method :Cuando, :When
end



Cuando /^(?:que )?visito (?:el|la) (?:p[áa]gina|portada|[íi]ndice|listado|colecci[óo]n) de ([\w\/]+)$/i do |modelo|
  model = modelo.to_unquoted.to_model or raise(ModelNotMapped.new(modelo))
  pile_up model.new
  visit eval("#{model.table_name}_path")
end


Cuando /^(?:que )?visito la p[áa]gina de ([\w\/]+) (?:de )?(.+)$/i do |accion, modelo|
  model = modelo.to_unquoted.to_model or raise(ModelNotMapped.new(modelo))
  action = accion.to_crud_action or raise(CrudActionNotMapped.new(accion))
  pile_up model.new
  visit eval("#{action}_#{model.name.downcase}_path")
end

Cuando /^(?:que )?visito su (?:p[áa]gina|portada)$/i do 
  visit last_mentioned_url
end

negative_lookahead = '(?:la|el) \w+ de |su p[aá]gina|su portada'
Cuando /^(?:que )?visito (?!#{negative_lookahead})(.+)$/i do |pagina|
  visit pagina.to_unquoted.to_url
end

Cuando /^(?:que )?(?:pulso|pincho) (?:en )?el bot[oó]n (.+)$/i do |boton|
  click_button(unquote(boton))
end

Cuando /^(?:que )?(?:pulso|pincho) (?:en )?el (enlace|enlace ajax|enlace con efectos) (.+)$/i do |tipo, enlace|
  options = {}
  options[:wait] = case tipo.downcase
  when 'enlace con efectos' then :effects
  when 'enlace ajax' then :ajax
  else :page
  end
  click_link(unquote(enlace), options)
end

Cuando /^(?:que )?(?:completo|relleno) (.+) con (?:el valor )?['"](.+)["']$/i do |campo, valor|
  field = campo_to_field(campo, last_mentioned_model)
  begin
    fill_in field, :with => valor
  rescue
    if singular = last_mentioned_singular
      fill_in singular + '_' + field.to_s, :with => valor
    else
      raise
    end
  end
end

Cuando /^(?:que )?elijo (?:la|el)? ?(.+) ['"](.+)["']$/i do |campo, valor|
  choose(campo_to_field(campo).to_s + '_' + valor.downcase.to_underscored)
end

Cuando /^(?:que )?marco (?:la|el)? ?(.+)$/i do |campo|
  check(campo_to_field(campo))
end

Cuando /^(?:que )?desmarco (?:la|el)? ?(.+)$/i do |campo|
  uncheck(campo_to_field(campo))
end

Cuando /^(?:que )?adjunto el fichero [\'"](.*)[\'"] (?:a|en) (.*)$/ do |ruta, campo|
  attach_file(campo_to_field(campo), ruta.to_local_path)
end

Cuando /^(?:que )?selecciono ["']([^"']+?)["'](?: en (?:el listado de )?(.+))?$/i do |valor, campo|
  select(valor, :from => campo_to_field(campo))
end

Cuando /^(?:que )?selecciono ['"]?(\d\d?) de (\w+) de (\d{4}), (\d\d?:\d\d)["']? como fecha y hora(?: (?:de )?['"](.+)["'])?$/ do |dia, mes, anio, hora, etiqueta|
# Cuando selecciono "25 de diciembre de 2008, 10:00" como fecha y hora
# Cuando selecciono 23 de noviembre de 2004, 11:20 como fecha y hora "Preferida"
# Cuando selecciono 23 de noviembre de 2004, 11:20 como fecha y hora de "Publicación"
  time = Time.parse("#{mes.to_month} #{dia}, #{anio} #{hora}")
  options = etiqueta ? { :from => etiqueta } : {}
  select_datetime(time, options)
end

Cuando /^(?:que )?selecciono ['"]?(.*)["']? como (?:la )?hora$/ do |hora|
  select_time(hora)
end

## Use this step when using multiple time_select helpers on a page or you want to
## specify the name of the time on the form.  For example:
## When I select "7:30AM" as the "Gym" time
#When /^I select "(.*)" as the "(.*)" time$/ do |time, time_label|
#  select_time(time, :from => time_label)
#end
#
## Use this step in conjuction with Rail's date_select helper.  For example:
## When I select "February 20, 1981" as the date
#When /^I select "(.*)" as the date$/ do |date|
#  select_date(date)
#end
#
## Use this step when using multiple date_select helpers on one page or
## you want to specify the name of the date on the form. For example:
## When I select "April 26, 1982" as the "Date of Birth" date
#When /^I select "(.*)" as the "(.*)" date$/ do |date, date_label|
#  select_date(date, :from => date_label)
#end
                                 
Cuando /^borro (?:el|la|el\/la) (.+) en (?:la )?(\w+|\d+)(?:ª|º)? posición$/ do |modelo, posicion|
  pile_up modelo.to_unquoted.to_model.new
  visit last_mentioned_url
  within("table > tr:nth-child(#{posicion.to_number+1})") do
    click_link "Borrar"
  end
end

