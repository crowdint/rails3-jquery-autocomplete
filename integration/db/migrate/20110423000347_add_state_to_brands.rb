class AddStateToBrands < ActiveRecord::Migration
  def self.up
    add_column :brands, :state, :boolean
  end

  def self.down
    remove_column :brands, :state
  end
end
