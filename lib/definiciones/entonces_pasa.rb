module Cucumber::StepMethods
  alias_method :Entonces, :Then
end

Entonces /^(veo|no veo|debo ver|no debo ver) la etiqueta ([^ ]+)(?: con el valor )?["']?([^"']+)?["']?$/ do |should, tag, value |
  if value
    response.body.send(shouldify(should), have_tag(tag, value))
  else
    response.body.send(shouldify(should), have_tag(tag))
  end
end
