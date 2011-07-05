module Rails3JQueryAutocomplete
  module Orm
    module ActiveRecord
      def get_autocomplete_order(method, options, model=nil)
        order = options[:order]

        table_prefix = model ? "#{model.table_name}." : ""
        order || "#{table_prefix}#{method} ASC"
      end

      def get_autocomplete_items(parameters)
        model      = parameters[:model]
        term       = parameters[:term]
        method     = parameters[:method]
        options    = parameters[:options]

        is_full_search = options[:full]
        scopes         = Array(options[:scopes])
        limit          = get_autocomplete_limit(options)
        order          = get_autocomplete_order(method, options, model)

        like_clause = (defined?(PGconn) ? 'ILIKE' : 'LIKE')

        items = model.scoped

        scopes.each { |scope| items = items.send(scope) } unless scopes.empty?

        table_name = model.table_name
        items = items.select(["#{table_name}.#{model.primary_key}", "#{table_name}.#{method}"] + (options[:extra_data].blank? ? [] : options[:extra_data])) unless options[:full_model]
        items = items.where(["LOWER(#{table_name}.#{method}) #{like_clause} ?", "#{(is_full_search ? '%' : '')}#{term.downcase}%"]) \
            .limit(limit).order(order)
      end
    end
  end
end
