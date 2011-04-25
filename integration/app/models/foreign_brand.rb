# == Schema Information
#
# Table name: brands
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  type       :string(255)
#  state      :boolean
#

class ForeignBrand < Brand

end
