# MundoPepino's step definitions in en_US
# Simple creation w/ optional name/s
Given /^(?:that we have )?(#{_number_}) (?!.+ #{_which_})(.+?)(?: (?:called )?['"](.+)["'])?$/i do |number, model, name|
  given_we_have_a_number_of_instances_called :number => number,
    :model => model, :name => name 
end

When /^#{_i_visit_} (.+)$/ do |page|
  given_or_when_i_do_a_page_request :page => page
end

Then /^I (#{_should_or_not_}) see the text (.+)$/ do |should, text|
  then_i_see_or_not_the_text :should => should, :text => text
end

Then /^we have (#{_number_}) ([^ ]+)(?: (?:called )?['"](.+)["'])? in our database$/ do |number, model, name|
  then_we_have_a_number_of_instances_in_our_database :number => number,
    :model => model, :name => name
end
