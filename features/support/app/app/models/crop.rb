class Crop < ActiveRecord::Base
  has_many :terraces
  has_many :sprinklers, :as => :sprinklerable
end
