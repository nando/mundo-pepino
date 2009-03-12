class Sprinkler < ActiveRecord::Base
  belongs_to :sprinklerable, :polymorphic => true
end
