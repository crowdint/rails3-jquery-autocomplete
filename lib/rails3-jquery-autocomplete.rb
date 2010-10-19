require 'form_helper'

module Rails3JQueryAutocomplete
  def self.included(base)
    base.extend(ClassMethods)
  end


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

        object = get_object(object)
        implementation = get_implementation(object)

        if implementation && params[:term] && !params[:term].empty?

          order = get_order(implementation, method, options)
          limit = get_limit(options)

          items = case implementation
            when :mongoid 
              search = (options[:full] ? '.*' : '^') + params[:term] + '.*'
              items = object.where(method.to_sym => /#{search}/i) \
                .limit(limit).order_by(order)
            when :activerecord
              items = object.where(["LOWER(#{method}) LIKE ?", "#{(options[:full] ? '%' : '')}#{params[:term].downcase}%"]) \
                .limit(limit).order(order)
          end

        else
          items = {}
        end

        render :json => json_for_autocomplete(items, (options[:display_value] ? options[:display_value] : method))
      end
    end
  end

  private
  def json_for_autocomplete(items, method)
    items.collect {|item| {"id" => item.id, "label" => item.send(method), "value" => item.send(method)}}
  end

  def get_object(model_sym)
    object = model_sym.to_s.camelize.constantize
  end

  def get_implementation(object) 
    if object.superclass.to_s == 'ActiveRecord::Base'
      :activerecord
    elsif object.included_modules.collect(&:to_s).include?('Mongoid::Document')
      :mongoid
    else
      nil
    end
  end

  def get_order(implementation, method, options)
    case implementation
      when :mongoid then
         options[:order] ? options[:order].split(',').collect {|orderer| [orderer.split[0].downcase.to_sym, orderer.split[1].downcase.to_sym] } : method.to_sym.asc
      when :activerecord then 
        options[:order] || "#{method} ASC"
      else nil
    end
  end

  def get_limit(options)
    limit = options[:limit] || 10
  end

end

class ActionController::Base
  include Rails3JQueryAutocomplete
end
