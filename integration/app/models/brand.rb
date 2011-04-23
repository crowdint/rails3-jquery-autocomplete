class Brand < ActiveRecord::Base
  scope :active, where(:state => true)
end
