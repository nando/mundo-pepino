class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.integer :user_id
      t.integer :flower_id
      t.boolean :light

      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
