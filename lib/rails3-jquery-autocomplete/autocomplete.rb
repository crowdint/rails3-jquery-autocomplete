require "yajl"

module Rails3JQueryAutocomplete

  # Inspired on DHH's autocomplete plugin
  #
  # Usage:
  #
  # class ProductsController < Admin::BaseController
  #   autocomplete :brand, :name
  # end
  #
  # This will magically generate an action autocomplete_brand_name, so,
  # don't forget to add it on your routes file
  #
  #   resources :products do
  #      get :autocomplete_brand_name, :on => :collection
  #   end
  #
  # Now, on your view, all you have to do is have a text field like:
  #
  #   f.text_field :brand_name, :autocomplete => autocomplete_brand_name_products_path
  #
  #
  module ClassMethods
    def autocomplete(object, method, options = {})

      define_method("autocomplete_#{object}_#{method}") do


        method = options[:column_name] if options.has_key?(:column_name)

        term = params[:term]

        if term && !term.empty?
          #allow specifying fully qualified class name for model object
          class_name = options[:class_name] || object
          items = get_autocomplete_items(:model => get_object(class_name), \
            :options => options, :term => term, :method => method)
        else
          items = {}
        end

        render :json => Yajl::Encoder.encode(json_for_autocomplete(items, options[:display_value] ||= method, options[:extra_data]))
      end
    end
  end

end

