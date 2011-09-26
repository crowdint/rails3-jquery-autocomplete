#
# Load the formtastic plugin if using Formtastic
#
begin
  require 'formtastic'
  begin
    require "formtastic/version"
  rescue LoadError
  end

  if defined?(Formtastic::VERSION)
    #
    # Formtastic 2.x
    #

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
  else

    #
    # Formtastic 1.x
    #
    class Formtastic::SemanticFormBuilder < ActionView::Helpers::FormBuilder
      include Rails3JQueryAutocomplete::FormtasticPlugin
    end
  end
rescue LoadError
end
