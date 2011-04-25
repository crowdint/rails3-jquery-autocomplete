# == Schema Information
#
# Table name: features
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Feature < ActiveRecord::Base
end
