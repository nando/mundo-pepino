class CreatePepinos < ActiveRecord::Migration
  def self.up
    create_table :pepinos do |t|
      t.string :name
      t.integer :weight
      t.string :variety
      t.integer :diameter
      t.integer :length

      t.timestamps
    end
  end

  def self.down
    drop_table :pepinos
  end
end
