module Cucumber::StepMethods
  alias_method :Cuando, :When
end

Cuando /^visito (.+)$/i do |pagina|
  visit case unquoted = unquote(pagina)
  when /su p[áa]gina$/i, /su portada$/i:
    last_resource_url
  else
    unquoted.to_url
  end
end

Cuando /^(?:pulso|pincho) (?:en )?el bot[oó]n (.+)$/i do |boton|
  clicks_button(unquote(boton))
end

