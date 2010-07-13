module AutoComplete      

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def autocomplete(object, method, options = {})
      limit = options[:limit] || 10
      order = options[:order] || "#{method} ASC"

      define_method("autocomplete_#{object}_#{method}") do        
        unless params[:q] && params[:q].empty?
          items = object.to_s.camelize.constantize.where(["LOWER(#{method}) LIKE ?", "#{params[:q]}%"]).limit(limit).order(order)
        else
          items = []
        end

        render :text => items.collect {|i| i[method]}.join("\n")
      end

    end
  end
end