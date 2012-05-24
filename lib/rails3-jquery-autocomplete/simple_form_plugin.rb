module SimpleForm

  module Inputs
    class AutocompleteInput < Base
      def input
        @builder.autocomplete_field(
          attribute_name,
          options[:url],
          rewrite_autocomplete_option
        )
      end

    protected

      def limit
        column && column.limit
      end

      def has_placeholder?
        placeholder_present?
      end

      #
      # Method used to rename the autocomplete key to a more standard
      # data-autocomplete key
      #
      private
      def rewrite_autocomplete_option
        new_options["data-update-elements"] = JSON.generate(options.delete :update_elements) if options[:update_elements]
        new_options["data-id-element"] = options.delete :id_element if options[:id_element]
        input_html_options.merge new_options
      end
    end
  end

  class FormBuilder
    map_type :autocomplete, :to => SimpleForm::Inputs::AutocompleteInput
  end

end
