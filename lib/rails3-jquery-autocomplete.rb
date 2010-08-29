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
      limit = options[:limit] || 10
      order = options[:order] || "#{method} ASC"

      define_method("autocomplete_#{object}_#{method}") do
        term = params[:term]
        unless term && term.empty?
          items = object.to_s.camelize.constantize.where(["LOWER(#{method}) LIKE ?", "#{(options[:full] ? '%' : '')}#{term.downcase}%"]).limit(limit).order(order)
        else
          items = {}
        end

        render :json => Rails3JQueryAutocomplete.json_for_autocomplete(items, method)
      end
    end
  end

  private
  def self.json_for_autocomplete(items, method)
    items.collect {|i| {"id" => i.id, "label" => i[method], "value" => i[method]}}
  end
end

class ActionController::Base
  include Rails3JQueryAutocomplete
end