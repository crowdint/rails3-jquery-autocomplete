module ActionView
  module Helpers
    module FormHelper
      # Returns an input tag of the "text" type tailored for accessing a specified attribute (identified by +method+) and
      # that is populated with jQuery's autocomplete plugin.
      #
      # ==== Examples
      #   autocomplete_field(:post, :title, author_autocomplete_path, :size => 20)
      #   # => <input type="text" id="post_title" name="post[title]" size="20" value="#{@post.title}"  data-autocomplete="author/autocomplete"/>
      #
      def autocomplete_field(object_name, method, source, options ={})
        options["data-autocomplete"] = source
        text_field(object_name, method, rewrite_autocomplete_option(options))
      end
    end

    module FormTagHelper
      # Creates a standard text field that can be populated with jQuery's autocomplete plugin
      #
      # ==== Examples
      #   autocomplete_field_tag 'address', '', address_autocomplete_path, :size => 75
      #   # => <input id="address" name="address" size="75" type="text" value="" data-autocomplete="address/autocomplete"/>
      #
      def autocomplete_field_tag(name, value, source, options ={})
        options["data-autocomplete"] = source
        text_field_tag(name, value, rewrite_autocomplete_option(options))
      end
    end

    #
    # Method used to rename the autocomplete key to a more standard
    # data-autocomplete key
    #
    private
    def rewrite_autocomplete_option(options)
      options["data-update-elements"] = JSON.generate(options.delete :update_elements) if options[:update_elements]
      options["data-id-element"] = options.delete :id_element if options[:id_element]
      options
    end
  end
end

class ActionView::Helpers::FormBuilder #:nodoc:
  def autocomplete_field(method, source, options = {})
    @template.autocomplete_field(@object_name, method, source, objectify_options(options))
  end
end
