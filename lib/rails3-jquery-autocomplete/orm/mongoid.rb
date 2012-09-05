module Rails3JQueryAutocomplete
  module Orm
    module Mongoid
      def order
        [[source_method, :asc]]
      end

      def where_clause(term)
        query = full_search ? '.*' + term + '.*' : '^' + term
        { source_method.to_sym => /#{query}/i }
      end

      def items(term)
        source_model.where(where_clause(term)).limit(limit).order_by(order)
      end

      def full_search
        false
      end
    end
  end
end
