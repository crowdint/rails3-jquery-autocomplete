require 'form_helper'
require 'rails3-jquery-autocomplete-helpers'

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

        object = Helpers.get_object(object)
        implementation = Helpers.get_implementation(object)

        if implementation && params[:term] && !params[:term].empty?

          order = Helpers.get_order(implementation, method, options)
          limit = Helpers.get_limit(options)

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

        render :json => Helpers.json_for_autocomplete(items, (options[:display_value] ? options[:display_value] : method))
      end
    end
  end

end

class ActionController::Base
  include Rails3JQueryAutocomplete
end
