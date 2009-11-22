class CreateFlowers < ActiveRecord::Migration
  def self.up
    create_table :flowers do |t|
      t.string :title
      t.integer :from_id
      t.string :file_path

      t.timestamps
    end
  end

  def self.down
    drop_table :flowers
  end
end
