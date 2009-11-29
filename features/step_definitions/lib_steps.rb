require 'mundo_pepino/en_US'

Given /^that I map (.+) to the model (.+)$/ do |string, model|
  String.model_mappings[string.to_unquoted] = model.to_unquoted.constantize # express the regexp above with the code you wish you had
end

Given /^the following default params:$/ do |table|
  @params = table.raw[1..-1].inject({}) do |hash, row|
    hash.merge(eval(row[0]) => row[1])
  end
end

Given /^the step implementation ([a-z_]+)$/ do |step_implementation|
  @step_implementation = step_implementation
end

When /^I call it with default params merged with (.+)$/ do |raiser_params|
  @raiser_params = eval('{'+raiser_params+'}')
end

Then /^I should receive the (.*) exception$/ do |exception|
  lambda {
    self.send @step_implementation, @params.merge(@raiser_params)
  }.should raise_error(eval("MundoPepino::#{exception}"))
end
