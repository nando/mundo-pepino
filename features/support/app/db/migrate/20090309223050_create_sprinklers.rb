class CreateSprinklers < ActiveRecord::Migration
  def self.up
    create_table :sprinklers do |t|
      t.string :name
      t.integer :flow
      t.string :flow_units
      t.references :sprinklerable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :sprinklers
  end
end
