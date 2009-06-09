class Lettuce < ActiveRecord::Base
  belongs_to :orchard_of_birth, :class_name => 'Orchard'
end
