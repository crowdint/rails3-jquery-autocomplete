module HelperMethods
  def enable_javascript
    Capybara.current_driver = :selenium
    Capybara.default_wait_time = 1
  end

  def send_to(element, key)
    find_field(element).native.send_keys(key)
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
