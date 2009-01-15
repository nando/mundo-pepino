class Orchard < ActiveRecord::Base
  belongs_to :fertilizer
  has_many :terraces

  def watering_time(type)
    if sw = self.send("#{type}_watering")
      "#{sw.hour}:#{sw.min}"
    else
      '--:--'
    end
  end
end
