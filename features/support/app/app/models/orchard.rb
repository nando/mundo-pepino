class Orchard < ActiveRecord::Base
  belongs_to :fertilizer
  has_many :terraces
  has_many :crops, :through => :terraces
  has_many :sprinklers, :as => :sprinklerable

  def watering_time(type)
    if sw = self.send("#{type}_watering")
      "#{sw.hour}:#{sw.min}"
    else
      '--:--'
    end
  end
end
