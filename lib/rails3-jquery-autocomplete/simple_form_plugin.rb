module SimpleForm

  module Inputs
    class AutocompleteInput < Base
      def input
        @builder.autocomplete_field(
          attribute_name,
          options[:url],
          html_options
        )
      end

    protected

      def limit
        column && column.limit
      end

      def has_placeholder?
        placeholder_present?
      end

      def html_options
        input_html_options.merge update_elements options[:update_elements]
      end

      def update_elements(elements)
        if elements
          {'data-update-elements' => elements.to_json}
        else
          {}
        end
      end
    end
  end

  class FormBuilder
    map_type :autocomplete, :to => SimpleForm::Inputs::AutocompleteInput
  end

end
