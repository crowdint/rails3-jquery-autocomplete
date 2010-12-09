Then /^the "([^"]*)" field should contain the "([^"]*)" brand id$/ do |field, name|
  brand = Brand.where(:name => name).first
  Then %{the "#{field}" field should contain "#{brand.id}"}
end

