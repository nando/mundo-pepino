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
