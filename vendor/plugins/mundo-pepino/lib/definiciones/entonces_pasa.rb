module Cucumber::StepMethods
  alias_method :Entonces, :Then
end

Entonces /^(debo|no debo) ver la etiqueta ([^ ]+)(?: con el valor )?["']?([^"']+)?["']?$/ do |should,
 tag, value|
# Ejemplo: Entonces No Debo ver la etiqueta H2 con el valor "Encabezándolo todo"
#  @last_tag = tag
  if value
    response.body.send(shouldify(should), have_tag(tag, value))
  else
    response.body.send(shouldify(should), have_tag(tag))
  end
  response.body.should == 'PASO IMPLEMENTADO PERO SIN TEST/DOC'
end
