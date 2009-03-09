class AddCultivatedToOrchard < ActiveRecord::Migration
  def self.up
    add_column :orchards, :cultivated, :boolean
  end

  def self.down
    remove_column :orchards, :cultivated
  end
end
