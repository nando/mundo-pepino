class CreateChards < ActiveRecord::Migration
  def self.up
    create_table :chards do |t|
      t.string :name
      t.integer :terrace_id, :null => false
      t.integer :weight
      t.string :variety
      t.integer :length

      t.timestamps
    end
  end

  def self.down
    drop_table :chards
  end
end
