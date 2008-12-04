Then /^existen? (un|una|\d+) ([^ ]+)(?: ['"](.+)["'])?$/ do |numero, modelo, nombre|
  @resources.size.should == numero.to_number
end
