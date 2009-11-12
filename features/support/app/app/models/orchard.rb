class Orchard < ActiveRecord::Base
  belongs_to :fertilizer
  has_many :terraces
  accepts_nested_attributes_for :terraces, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? {|k,v| v.blank?} }

  has_many :crops, :through => :terraces
  has_many :sprinklers, :as => :sprinklerable

  def watering_time(type)
    if sw = self.send("#{type}_watering")
      format("%d:%02d", sw.hour, sw.min)
    else
      '--:--'
    end
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
