class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :nick
      t.string :password
      t.boolean :dark_past

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
