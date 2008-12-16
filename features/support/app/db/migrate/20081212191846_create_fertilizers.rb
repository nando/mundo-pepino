class CreateFertilizers < ActiveRecord::Migration
  def self.up
    create_table :fertilizers do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end

  def self.down
    drop_table :fertilizers
  end
end
