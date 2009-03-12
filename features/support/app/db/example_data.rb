module FixtureReplacement
  attributes_for :orchard do |a|
    a.name = String.random
    a.area = rand(200)
  end

  attributes_for :terrace do |a|
    a.name = String.random
    a.orchard = default_orchard
    a.length = rand(60)
    a.plants = rand(90)
    a.crop = default_crop
  end

  attributes_for :crop do |a|
    a.name = String.random
  end

  attributes_for :fertilizer do |a|
    a.name = String.random
  end

  attributes_for :chard do |a|
    a.terrace = default_terrace
    a.weight = 0
    a.length = 0
  end

  attributes_for :tomato do |a|
    a.terrace = default_terrace
    a.weight = 0
    a.diameter = 0
  end

  attributes_for :pepino do |a|
    a.terrace = default_terrace
    a.weight = 0
    a.length = 0
    a.diameter = 0
  end

  attributes_for :sprinkler do |a|
    a.sprinklerable = default_orchard
    a.name = String.random
    a.flow = 10
    a.flow_units = 'm3'
  end
end
