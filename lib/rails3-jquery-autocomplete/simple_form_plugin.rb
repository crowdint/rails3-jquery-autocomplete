module SimpleForm
  module Inputs
    class AutocompleteInput < Base
      def input
        @builder.autocomplete_field(attribute_name, options[:url], input_html_options.merge(update_elements(options[:update_elements])))
      end

    protected

      def limit
        column && column.limit
      end

      def has_placeholder?
        placeholder_present?
      end

      def update_elements(elements)
        {'data-update-elements' => elements.to_json}
      end
    end
  end
end

module SimpleForm
  class FormBuilder
    map_type :autocomplete, :to => SimpleForm::Inputs::AutocompleteInput
  end
end
