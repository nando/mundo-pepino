module Cucumber::StepMethods
  alias_method :Cuando, :When
end

Cuando /^visito (.+)$/i do |url_o_nombre|
  visit url_o_nombre.to_url
end
