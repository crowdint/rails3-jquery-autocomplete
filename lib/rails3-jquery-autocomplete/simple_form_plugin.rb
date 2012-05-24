module SimpleForm

  module Inputs
    class AutocompleteInput < Base
      def input
        out = ""
        out << @builder.autocomplete_field(
          attribute_name,
          options[:url],
          rewrite_autocomplete_option
        )
        if options[:hidden_id]
          out << @builder.hidden_field(
            attribute_name,
            input_html_options
          )
        end
        out.html_safe
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
        new_options = {}
        new_options["data-update-elements"] = JSON.generate(options.delete :update_elements) if options[:update_elements]
        id_element = options.delete :id_element
        if options[:hidden_id]
          if id_element
            id_element << ", ##{object_name}_#{attribute_name}[type=hidden]"
          else
            id_element = "##{object_name}_#{attribute_name}[type=hidden]"
          end
        end
        new_options["data-id-element"] = id_element
        input_html_options.merge new_options
      end
    end
  end

  class FormBuilder
    map_type :autocomplete, :to => SimpleForm::Inputs::AutocompleteInput
  end

end
