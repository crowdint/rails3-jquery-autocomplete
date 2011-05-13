class AddAddressIdToBrand < ActiveRecord::Migration
  def self.up
    add_column :brands, :address_id, :integer
  end

  def self.down
    remove_column :brands, :address_id
  end
end
