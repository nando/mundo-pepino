class Terrace < ActiveRecord::Base
  belongs_to :orchard
  belongs_to :crop
end
