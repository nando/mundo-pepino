module FixtureReplacement
  attributes_for :orchard do |a|
    name = String.random
    area = rand(200)
  end
  attributes_for :terrace do |a|
    name = String.random
    orchard = default_orchard
    meters = rand(60)
    plants = rand(90)
    crop = default_crop
  end
  attributes_for :crop do |a|
    name = String.random
  end
  attributes_for :fertilizer do |a|
    name = String.random
  end
  attributes_for :chard do |a|
    orchard = default_orchard
    weight = 0
    length = 0
  end
  attributes_for :tomato do |a|
    orchard = default_orchard
    weight = 0
    diameter = 0
  end
  attributes_for :pepino do |a|
    orchard = default_orchard
    weight = 0
    length = 0
    diameter = 0
  end
end
