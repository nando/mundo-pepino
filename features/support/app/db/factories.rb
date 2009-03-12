# Standard factory_girl syntax for factories
#
# Alternate Syntaxes
#
# Users’ tastes for syntax vary dramatically, but most users are looking for a common feature set. Because of this, 
# factory_girl supports "syntax layers" which provide alternate interfaces. 
# See http://dev.thoughtbot.com/factory_girl/classes/Factory/Syntax.html for information about the various layers 
# available. 

Factory.define :orchard do |f|
  f.sequence(:name) {|n| "orchard#{n}" }
  f.area { rand(200) }
end

Factory.define :terrace do |f|
  f.sequence(:name) {|n| "terrace#{n}" }
  f.association :orchard, :factory => :orchard
  f.length { rand(60) }
  f.plants { rand(90) }
  f.association :crop, :factory => :crop
end

Factory.define :crop do |f|
  f.sequence(:name) {|n| "crop#{n}" }
end

Factory.define :fertilizer do |f|
  f.sequence(:name) {|n| "fertilizer#{n}" }
end

Factory.define :chard do |f|
  f.association :terrace, :factory => :terrace
  f.weight 0
  f.length 0
end

Factory.define :tomato do |f|
  f.association :terrace, :factory => :terrace
  f.weight 0
  f.diameter 0
end

Factory.define :pepino do |f|
  f.association :terrace, :factory => :terrace
  f.weight 0
  f.length 0
  f.diameter 0
end

# No probado
#Factory.define :sprinkler do |f|
#  f.association :sprinklerable, :factory => :orchard
#  f.flow 0
#  f.unit_flow "m3"
#end

