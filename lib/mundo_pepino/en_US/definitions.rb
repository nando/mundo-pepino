# MundoPepino's step definitions in en_US
# Simple creation w/ optional name/s
Given /^(?:that we have )?(#{_number_}) (?!.+ #{_which_})(.+?)(?: (?:called )?['"](.+)["'])?$/i do |number, model, name|
  given_we_have_a_number_of_instances_called number, model, name 
end

Then /^we have (#{_number_}) ([^ ]+)(?: (?:called )?['"](.+)["'])? in our database$/ do |number, model, names|
  then_we_have_a_number_of_instances_in_our_database number, model, names
end
