module ActionView
  module Helpers
    module FormHelper
      alias_method :original_text_field, :text_field
      def text_field(object_name, method, options = {})
        original_text_field(object_name, method, rename_autocomplete_option(options))
      end

      # Returns an input tag of the "text" type tailored for accessing a specified attribute (identified by +method+) and
      # that is populated with jQuery's autocomplete plugin.
      #
      # ==== Examples
      #   autocomplete_field(:post, :title, author_autocomplete_path, :size => 20)
      #   # => <input type="text" id="post_title" name="post[title]" size="20" value="#{@post.title}"  data-autocomplete="author/autocomplete"/>
      #
      def autocomplete_field(object_name, method, source, options ={})
        options[:autocomplete] = source
        text_field(object_name, method, options)
      end
    end

    module FormTagHelper
      alias_method :original_text_field_tag, :text_field_tag
      def text_field_tag(name, value = nil, options = {})
        original_text_field_tag(name, value, rename_autocomplete_option(options))
      end

      # Creates a standard text field that can be populated with jQuery's autocomplete plugin
      #
      # ==== Examples
      #   autocomplete_field_tag 'address', '', address_autocomplete_path, :size => 75
      #   # => <input id="address" name="address" size="75" type="text" value="" data-autocomplete="address/autocomplete"/>
      #
      def autocomplete_field_tag(name, value, source, options ={})
        options[:autocomplete] = source
        text_field_tag(name, value, options)
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

class ActionView::Helpers::FormBuilder #:nodoc:
  def autocomplete_field(method, source, options = {})
    @template.autocomplete_field(@object_name, method, source, options)
  end
end
