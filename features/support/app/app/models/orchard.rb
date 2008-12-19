class Orchard < ActiveRecord::Base
  belongs_to :fertilizer
  has_many :terraces
end
