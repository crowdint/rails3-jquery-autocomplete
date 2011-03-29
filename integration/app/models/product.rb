class Product < ActiveRecord::Base
  attr_accessor :brand_id

  has_many :features
  accepts_nested_attributes_for :features
end
