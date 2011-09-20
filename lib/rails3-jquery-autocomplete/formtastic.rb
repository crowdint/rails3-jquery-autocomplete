#
# Load the formtastic plugin if using Formtastic
begin
  require 'formtastic'
  module Formtastic
    module Inputs
      class AutocompleteInput
        include Base
        include Base::Stringish

        def to_html
          input_wrapping do
            label_html <<
              builder.autocomplete_field(method, options.delete(:url), input_html_options)
          end
        end
      end
    end
  end
rescue LoadError
end
