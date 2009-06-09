class CreateLettuces < ActiveRecord::Migration
  def self.up
    create_table :lettuces do |t|
      t.integer :id
      t.string :name
      t.integer :orchard_of_birth_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orchard_lettuces
  end
end
