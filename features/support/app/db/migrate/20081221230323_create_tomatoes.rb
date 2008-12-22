class CreateTomatoes < ActiveRecord::Migration
  def self.up
    create_table :tomatoes do |t|
      t.string :name
      t.integer :weight
      t.string :variety
      t.integer :diameter
      t.integer :length

      t.timestamps
    end
  end

  def self.down
    drop_table :tomatoes
  end
end
