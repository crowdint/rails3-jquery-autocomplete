Then /^the "([^"]*)" field should contain the "([^"]*)" brand id$/ do |field, name|
  brand = Brand.where(:name => name).first
  Then %{the "#{field}" field should contain "#{brand.id}"}
end

And /^I send (.*) to "(.*)"$/ do |key, element|
  find_field(element).native.send_keys(key)
end


