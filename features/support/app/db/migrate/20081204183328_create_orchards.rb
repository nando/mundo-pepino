class CreateOrchards < ActiveRecord::Migration
  def self.up
    create_table :orchards do |t|
      t.string :name
      t.date :since
      t.integer :area
      t.string :longitude
      t.string :latitude
      t.time   :start_watering
      t.time   :stop_watering

      t.integer :fertilizer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orchards
  end
end
