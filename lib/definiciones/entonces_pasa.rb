module Cucumber::StepMethods
  alias_method :Entonces, :Then
end

Entonces /^(veo|no veo|debo ver|no debo ver) el texto (.+)?$/i do |should, text|
  eval('response.body.send(shouldify(should))') =~ /#{unquote(text)}/m
end

Entonces /^(veo|no veo|debo ver|no debo ver) (?:la etiqueta|el tag) ([^ ]+)(?: con el valor )?["']?([^"']+)?["']?$/ do |should, tag, value |
  if value
    response.body.send(shouldify(should), have_tag(tag, value))
  else
    response.body.send(shouldify(should), have_tag(tag))
  end
end

