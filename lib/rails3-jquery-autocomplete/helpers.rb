module Rails3JQueryAutocomplete
  module Helpers

    def self.json_for_autocomplete(items, method)
      items.collect {|item| {"id" => item.id, "label" => item.send(method), "value" => item.send(method)}}
    end

    def self.get_object(model_sym)
      object = model_sym.to_s.camelize.constantize
    end

    def self.get_implementation(object) 
      if object.superclass.to_s == 'ActiveRecord::Base'
        :activerecord
      elsif object.included_modules.collect(&:to_s).include?('Mongoid::Document')
        :mongoid
      else
        nil
      end
    end

    def self.get_order(implementation, method, options)
      case implementation
        when :mongoid then
           options[:order] ? options[:order].split(',').collect {|orderer| [orderer.split[0].downcase.to_sym, orderer.split[1].downcase.to_sym] } : [[method.to_sym, :asc]]
        when :activerecord then 
          options[:order] || "#{method} ASC"
        else nil
      end
    end

    def self.get_limit(options)
      limit = options[:limit] || 10
    end

  end
end
