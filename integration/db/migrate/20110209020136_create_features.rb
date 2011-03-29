class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.string :name
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :features
  end
end
