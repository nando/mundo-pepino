class CreateTerraces < ActiveRecord::Migration
  def self.up
    create_table :terraces do |t|
      t.string :name
      t.integer :orchard_id
      t.integer :crop_id
      t.integer :length
      t.integer :plants

      t.timestamps
    end
  end

  def self.down
    drop_table :terraces
  end
end
