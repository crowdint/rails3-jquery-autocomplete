module Rails3JQueryAutocomplete
  module Orm
    module Mongoid
      def order
        [[source_method, :asc]]
      end

      # TODO: Implement full_search with the following legacy logic:
      #
      # if is_full_search
      #   search = '.*' + term + '.*'
      # else
      #   search = '^' + term
      # end
      #
      #
      def where_clause(term)
        query = '^' + term
        { source_method.to_sym => /#{query}/i }
      end

      def items(term)
        source_model.where(where_clause(term)).limit(limit).order_by(order)
      end
    end
  end
end
