class Flower < ActiveRecord::Base
  belongs_to :from, :class_name => 'User'
  has_many :deliveries
  has_many :users, :through => :deliveries
end
