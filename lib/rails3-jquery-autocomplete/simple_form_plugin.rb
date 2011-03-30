module SimpleForm
  module Inputs
    class AutocompleteInput < Base
      def input
        @builder.autocomplete_field(attribute_name, options[:url], input_html_options)
      end

    protected

      def limit
        column && column.limit
      end

      def has_placeholder?
        placeholder_present?
      end
    end
  end
end

module SimpleForm
  class FormBuilder
    map_type :autocomplete, :to => SimpleForm::Inputs::AutocompleteInput
  end
end
