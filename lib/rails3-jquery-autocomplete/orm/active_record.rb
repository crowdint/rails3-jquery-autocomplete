module Rails3JQueryAutocomplete
  module Orm
    module ActiveRecord
      def order
        "#{source_model.table_name}.#{source_method} ASC"
      end

      def items(term)
        objects = source_model.scoped
        objects = objects.where(where_clause(term)).limit(limit).order(order)
      end

      def where_clause(term)
        table_name = source_model.table_name
        like_clause = (postgres?(source_model) ? 'ILIKE' : 'LIKE')
        ["LOWER(#{table_name}.#{source_method}) #{like_clause} ?", "#{(full_search ? '%' : '')}#{term.downcase}%"]
      end

      def full_search
        false
      end

      #
      # Method used to figure out if the specified model uses postgres
      #
      def postgres?(model)
        model.connection.class.to_s.match(/PostgreSQLAdapter/)
      end
    end
  end
end
