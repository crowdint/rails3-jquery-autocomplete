module Rails3JQueryAutocomplete
  module Controller
    #
    # This is the action that will return the JSON for the
    # autocomplete plugin
    #
    #
    def show
      render :json => items_to_json(params[:term])
    end

    #
    # Limits the number of results
    #
    def limit
      10
    end

    #
    # Iterates over the items and returns the json for the autocomplete plugin
    #
    def items_to_json(term)
      items(term).collect do |item|
        {
            "id"    => item.id.to_s,
            "label" => item.send(source_method),
            "value" => item.send(source_method)
        }
      end
    end

    #
    # Converts a sym into a constant
    #
    def sym_to_class(class_sym)
      class_sym.to_s.camelize.constantize
    end
  end
end
