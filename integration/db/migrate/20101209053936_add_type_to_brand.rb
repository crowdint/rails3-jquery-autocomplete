class AddTypeToBrand < ActiveRecord::Migration
  def self.up
    add_column :brands, :type, :string
  end

  def self.down
    remove_column :brands, :type
  end
end
