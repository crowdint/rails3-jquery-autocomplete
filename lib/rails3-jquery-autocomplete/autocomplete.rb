module Rails3JQueryAutocomplete
  module Autocomplete
    def self.included(target)
      target.extend Rails3JQueryAutocomplete::Autocomplete::ClassMethods
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

          render :json => if block_given?
                            yield json_for_autocomplete(items, options[:display_value] ||= method, options[:extra_data])
                          else
                            require 'yajl'
                            Yajl::Encoder.encode(json_for_autocomplete(items, options[:display_value] ||= method, options[:extra_data]))
                          end
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
    def json_for_autocomplete(items, method, extra_data=nil)
      items.collect do |item|
        hash = {"id" => item.id.to_s, "label" => item.send(method), "value" => item.send(method)}
        extra_data.each do |datum|
          hash[datum] = item.send(datum)
        end if extra_data
        hash
      end
    end

    # Returns a symbol representing what implementation should be used to query
    # the database and raises *NotImplementedError* if ORM implementor can not be found
    def get_implementation(object)
      ancestors_ary = object.ancestors.collect(&:to_s)
      if ancestors_ary.include?('ActiveRecord::Base')
        :activerecord
      elsif ancestors_ary.include?('Mongoid::Document')
        :mongoid
      elsif ancestors_ary.include?('MongoMapper::Document')
        :mongo_mapper
      else
        raise NotImplementedError
      end
    end

    #DEPRECATED
    def get_order(implementation, method, options)
      warn 'Rails3JQueryAutocomplete#get_order is has been DEPRECATED, please use #get_autocomplete_order instead'
      get_autocomplete_order(implementation, method, options)
    end

    # Returns the order parameter to be used in the query created by get_items
    def get_autocomplete_order(implementation, method, options, model=nil)
      order = options[:order]

      case implementation
        when :mongoid then
          if order
            order.split(',').collect do |fields|
              sfields = fields.split
              [sfields[0].downcase.to_sym, sfields[1].downcase.to_sym]
            end
          else
            [[method.to_sym, :asc]]
          end
        when :mongo_mapper then
          if order
            order.split(',').collect do |fields|
              sfields = fields.split
              [sfields[0].downcase.to_sym, sfields[1].downcase.to_sym]
            end
          else
            [[method.to_sym, :asc]]
          end  
        when :activerecord then
          table_prefix = model ? "#{model.table_name}." : ""
          order || "#{table_prefix}#{method} ASC"
      end
    end

    # DEPRECATED
    def get_limit(options)
      warn 'Rails3JQueryAutocomplete#get_limit is has been DEPRECATED, please use #get_autocomplete_limit instead'
      get_autocomplete_limit(options)
    end

    # Returns a limit that will be used on the query
    def get_autocomplete_limit(options)
      options[:limit] ||= 10
    end

    # DEPRECATED
    def get_items(parameters)
      warn 'Rails3JQueryAutocomplete#get_items is has been DEPRECATED, you should use #get_autocomplete_items instead'
      get_autocomplete_items(parameters)
    end

    #
    # Can be overriden to return or filter however you like
    # the objects to be shown by autocomplete
    #
    #   items = get_autocomplete_items(:model => get_object(object), :options => options, :term => term, :method => method)
    #
    def get_autocomplete_items(parameters)
      model      = parameters[:model]
      term       = parameters[:term]
      method     = parameters[:method]
      options    = parameters[:options]

      is_full_search = options[:full]
      scopes         = Array(options[:scopes])
      limit          = get_autocomplete_limit(options)
      implementation = get_implementation(model)
      order          = get_autocomplete_order(implementation, method, options, model)

      like_clause = (defined?(PGconn) ? 'ILIKE' : 'LIKE')

      implementation == :mongo_mapper ? (items = model.query) : items = model.scoped

      scopes.each { |scope| items = items.send(scope) } unless scopes.empty?

      case implementation
        when :mongoid
          search = (is_full_search ? '.*' : '^') + term + '.*'
          items  = model.where(method.to_sym => /#{search}/i).limit(limit).order_by(order)
        when :mongo_mapper
          search = (is_full_search ? '.*' : '^') + term + '.*'
          items  = model.where(method.to_sym => /#{search}/i).limit(limit).sort(order)  
        when :activerecord
          table_name = model.table_name
          items = items.select(["#{table_name}.#{model.primary_key}", "#{table_name}.#{method}"] + (options[:extra_data].blank? ? [] : options[:extra_data])) unless options[:full_model]
          items = items.where(["LOWER(#{table_name}.#{method}) #{like_clause} ?", "#{(is_full_search ? '%' : '')}#{term.downcase}%"]) \
              .limit(limit).order(order)
      end
    end
  end
end

