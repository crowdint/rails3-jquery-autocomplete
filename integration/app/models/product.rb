# == Schema Information
#
# Table name: products
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  brand_name :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Product < ActiveRecord::Base
  attr_accessor :brand_id

  has_many :features
  accepts_nested_attributes_for :features
end
