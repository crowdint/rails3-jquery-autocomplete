class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :street

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
