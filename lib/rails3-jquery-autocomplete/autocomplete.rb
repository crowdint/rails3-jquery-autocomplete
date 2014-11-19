module Rails3JQueryAutocomplete
  module Autocomplete
    def self.included(target)
      target.extend Rails3JQueryAutocomplete::Autocomplete::ClassMethods

      target.send :include, Rails3JQueryAutocomplete::Orm::Mongoid if defined?(Mongoid::Document)
      target.send :include, Rails3JQueryAutocomplete::Orm::MongoMapper if defined?(MongoMapper::Document)
      target.send :include, Rails3JQueryAutocomplete::Orm::ActiveRecord

    end

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
    # Yajl is used by default to encode results, if you want to use a different encoder
    # you can specify your custom encoder via block
    #
    # class ProductsController < Admin::BaseController
    #   autocomplete :brand, :name do |items|
    #     CustomJSONEncoder.encode(items)
    #   end
    # end
    #
    module ClassMethods
      def autocomplete(object, method, options = {}, &block)

        define_method("get_prefix") do |model|
          if defined?(Mongoid::Document) && model.include?(Mongoid::Document)
            'mongoid'
          elsif defined?(MongoMapper::Document) && model.include?(MongoMapper::Document)
            'mongo_mapper'
          else
            'active_record'
          end
        end
        define_method("get_autocomplete_order") do |method, options, model=nil|
          method("#{get_prefix(get_object(options[:class_name] || object))}_get_autocomplete_order").call(method, options, model)
        end

        define_method("get_autocomplete_items") do |parameters|
          method("#{get_prefix(get_object(options[:class_name] || object))}_get_autocomplete_items").call(parameters)
        end

        define_method("autocomplete_#{object}_#{method}") do

          method = options[:column_name] if options.has_key?(:column_name)

          term = params[:term]

          if term && !term.blank?
            #allow specifying fully qualified class name for model object
            class_name = options[:class_name] || object
            items = get_autocomplete_items(:model => get_object(class_name), \
              :options => options, :term => term, :method => method)
          else
            items = {}
          end

          render :json => json_for_autocomplete(items, options[:display_value] ||= method, options[:extra_data], &block), root: false
        end
      end
    end

    # Returns a limit that will be used on the query
    def get_autocomplete_limit(options)
      options[:limit] ||= 10
    end

    # Returns parameter model_sym as a constant
    #
    #   get_object(:actor)
    #   # returns a Actor constant supposing it is already defined
    #
    def get_object(model_sym)
      object = model_sym.to_s.camelize.constantize
    end

    #
    # Returns a hash with three keys actually used by the Autocomplete jQuery-ui
    # Can be overriden to show whatever you like
    # Hash also includes a key/value pair for each method in extra_data
    #
    def json_for_autocomplete(items, method, extra_data=[])
      items = items.collect do |item|
        hash = {"id" => item.id.to_s, "label" => item.send(method), "value" => item.send(method)}
        extra_data.each do |datum|
          hash[datum] = item.send(datum)
        end if extra_data
        # TODO: Come back to remove this if clause when test suite is better
        hash
      end
      if block_given?
        yield(items)
      else 
        items
      end
    end
  end
end

