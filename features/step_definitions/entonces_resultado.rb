

Given /^que tengo la expectiva de recibir 3 veces "visits" con "\/"$/ do
  webrat = mock()
  ActionController::Integration::Session.any_instance.stubs(:new).returns(webrat)
  webrat.expects(:visit).with('hola').times(3)
end


Then /^existen? (un|una|\d+) ([^ ]+)(?: ['"](.+)["'])?$/ do |numero, modelo, nombre|
  model = modelo.to_model
  @resources.select do |resource|
    resource.is_a?(model) and (nombre.nil? or (nombre == resource.name)) 
  end.size.should == numero.to_number
end

Then /^el (.+) "(.+)" tiene como (.+) "(.+)"$/ do |modelo, nombre, campo, valor|
  @then_resource = modelo.to_model.find_by_name(nombre)
  (@then_resource.send campo.to_field).to_s.should == valor
end

Then /^como (.+) "(.+)"$/ do |campo, valor|
  (@then_resource.send campo.to_field).to_s.should == valor
end
