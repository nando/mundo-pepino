require 'mundo_pepino/en_US'

MundoPepino.configure do |config|
  config.models_to_clean = [
    Orchard,
    Terrace,
    Crop,
    Fertilizer,
    Tomato,
    Chard,
    Pepino,
    Lettuce,
    Sprinkler
  ]
  config.model_mappings = {
    /^orchards?$/i    => Orchard,
    /^terraces?$/i    => Terrace,
    /^crops?$/i       => Crop,
    /^fertilizers?$/i => Fertilizer,
    /^tomatoes?$/i    => Tomato,
    /^chards?$/i		  => Chard,
    /^cucumbers?$/i	  => Pepino,
    /^sprinklers?$/i  => Sprinkler,
    /^lettuces?$/i    => Lettuce
  }
end

Before do
  MundoPepino.clean_models
end

module MundoPepino
  include FixtureReplacement
end
