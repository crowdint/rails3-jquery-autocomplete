module Rails3JQueryAutocomplete

  # Contains utility methods used by autocomplete
  module Helpers

    # Returns a three keys hash 
    def json_for_autocomplete(items, method)
      items.collect {|item| {"id" => item.id, "label" => item.send(method), "value" => item.send(method)}}
    end

    # Returns parameter model_sym as a constant
    #
    #   get_object(:actor)
    #   # returns a Actor constant supposing it is already defined
    def get_object(model_sym)
      object = model_sym.to_s.camelize.constantize
    end

    # Returns a symbol representing what implementation should be used to query
    # the database and raises *NotImplementedError* if ORM implementor can not be found
    def get_implementation(object) 
      ancestors_ary = object.ancestors.collect(&:to_s)
      if ancestors_ary.include?('ActiveRecord::Base')
        :activerecord
      elsif ancestors_ary.include?('Mongoid::Document')
        :mongoid
      else
        raise NotImplementedError
      end
    end

    # Returns the order parameter to be used in the query created by get_items
    def get_order(implementation, method, options)
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
        when :activerecord then 
          order || "#{method} ASC"
      end
    end

    # Returns a limit that will be used on the query    
    def get_limit(options)
      options[:limit] ||= 10
    end
  
    # Queries selected database
    #
    #   items = get_items(:model => get_object(object), :options => options, :term => term, :method => method) 
    def get_items(parameters)

      model = parameters[:model]
      method = parameters[:method]
      options = parameters[:options]
      term = parameters[:term]
      is_full_search = options[:full]

      limit = get_limit(options)
      implementation = get_implementation(model)
      order = get_order(implementation, method, options)

      case implementation
        when :mongoid
          search = (is_full_search ? '.*' : '^') + term + '.*'
          items = model.where(method.to_sym => /#{search}/i).limit(limit).order_by(order)
        when :activerecord
          items = model.where(["LOWER(#{method}) LIKE ?", "#{(is_full_search ? '%' : '')}#{term.downcase}%"]) \
            .limit(limit).order(order)
      end
    end

  end
end
