class User < ActiveRecord::Base
  has_many :sended_flowers, :class_name => 'Flower', :foreign_key => 'from_id'
  has_many :deliveries
  has_many :flowers, :through => :deliveries
end
