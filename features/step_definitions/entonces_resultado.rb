Then /^existen? (un|una|\d+) ([^ ]+)(?: ['"](.+)["'])?$/ do |numero, modelo, nombre|
  model = modelo.to_model
  @resources.select do |resource|
    resource.is_a?(model) and (nombre.nil? or (nombre == resource.name)) 
  end.size.should == numero.to_number
end
