class Terrace < ActiveRecord::Base
  belongs_to :orchard
  belongs_to :crop
  has_many   :chards
  has_many   :tomatoes
  has_many   :pepinos
end
