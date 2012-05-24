module SimpleForm
  module Inputs
    module Autocomplete
      #
      # Method used to rename the autocomplete key to a more standard
      # data-autocomplete key
      #
      def rewrite_autocomplete_option
        new_options = {}
        new_options["data-update-elements"] = JSON.generate(options.delete :update_elements) if options[:update_elements]
        new_options["data-id-element"] = options.delete :id_element if options[:id_element]
        input_html_options.merge new_options
      end
    end

    class AutocompleteInput < Base
      include Autocomplete

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
    end

    class AutocompleteCollectionInput < CollectionInput
      include Autocomplete

      def input
        id_element = options[:id_element]
        if id_element
          id_element << ", ##{object_name}_#{attribute_name}[type=hidden]"
        else
          id_element = "##{object_name}_#{attribute_name}[type=hidden]"
        end
        options[:id_element] = id_element
        autocomplete_options = rewrite_autocomplete_option
        #
        label_method, value_method = detect_collection_methods
        association = object.send(reflection.name)
        if association && association.respond_to?(label_method)
          autocomplete_options[:value] = association.send(label_method)
        end
        out = @builder.autocomplete_field(
          attribute_name,
          options[:url],
          autocomplete_options
        )
        hidden_options = if association && association.respond_to?(value_method)
          new_options = {}
          new_options[:value] = association.send(value_method)
          input_html_options.merge new_options
        else
          input_html_options
        end
        out << @builder.hidden_field(
          attribute_name,
          hidden_options
        )
        out.html_safe
      end
    end
  end

  class FormBuilder
    map_type :autocomplete, :to => SimpleForm::Inputs::AutocompleteInput
    map_type :autocomplete_collection, :to => SimpleForm::Inputs::AutocompleteCollectionInput
  end

end
