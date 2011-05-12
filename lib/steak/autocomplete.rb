module Steak
  module Autocomplete
    def choose_autocomplete_result(text, input_id="input[data-autocomplete]")
      page.execute_script %Q{ $('#{input_id}').trigger("focus") }
      page.execute_script %Q{ $('#{input_id}').trigger("keydown") }
      sleep 1
      page.execute_script %Q{ $('.ui-menu-item a:contains("#{text}")').trigger("mouseenter").trigger("click"); }
    end
  end
end

RSpec.configuration.include Steak::Autocomplete, :type => :acceptance
