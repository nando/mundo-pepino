class PepinoNameFieldIsNowTitle < ActiveRecord::Migration
  def self.up
    remove_column :pepinos, :name
    add_column :pepinos, :title, :string
  end

  def self.down
    remove_column :pepinos, :title
    add_column :pepinos, :name, :string
  end
end
