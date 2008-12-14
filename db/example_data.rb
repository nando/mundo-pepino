module FixtureReplacement
  attributes_for :orchard do |a|
    name = String.random
    area = rand(200)
  end
  attributes_for :fertilizer do |a|
    name = String.random
  end
end
