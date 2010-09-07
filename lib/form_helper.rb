module ActionView
  module Helpers
    module FormHelper
      alias_method :original_text_field, :text_field
      def text_field(object_name, method, options = {})
        original_text_field(object_name, method, rename_autocomplete_option(options))
      end
    end

    module FormTagHelper
      alias_method :original_text_field_tag, :text_field_tag
      def text_field_tag(name, value = nil, options = {})
        original_text_field_tag(name, value, rename_autocomplete_option(options))
      end
    end

    #
    # Method used to rename the autocomplete key to a more standard
    # data-autocomplete key
    #
    private
    def rename_autocomplete_option(options)
      options["data-autocomplete"] = options.delete(:autocomplete)
      options
    end
  end
end