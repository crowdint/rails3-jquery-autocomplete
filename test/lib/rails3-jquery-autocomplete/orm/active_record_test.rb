require 'test_helper'

module Rails3JQueryAutocomplete
  module Orm
    class ActiveRecordTest < Test::Unit::TestCase
      include Rails3JQueryAutocomplete::Orm::ActiveRecord
      include Rails3JQueryAutocomplete::Controller

      def test_order
        mock(self).source_model.stub!.table_name { 'table' }
        mock(self).source_method { 'method' }
        assert_equal order, 'table.method ASC'
      end

      def test_items
        active_record_scope, result = stub, stub

        terms = 'terms'
        expected_where = "WHERE table.column LIKE '%terms'"
        expected_order = "ORDER BY table.column ASC"

        mock(self).source_model.stub!.scoped { active_record_scope }

        mock(self).where_clause(terms) { expected_where }
        mock(self).order { expected_order }

        mock(active_record_scope).where(expected_where).mock!.limit(10).
          mock!.order(expected_order) { result }

        assert_equal items(terms), result
      end

      def test_where_clause_with_postgres
        setup_database_models

        mock(self).postgres?(@model) { true }

        assert_equal where_clause(@term), ['LOWER(table_name.column) ILIKE ?', 'term%']
      end

      def test_where_clause_with_others
        setup_database_models

        mock(self).postgres?(@model) { false }

        assert_equal where_clause(@term), ['LOWER(table_name.column) LIKE ?', 'term%']
      end

      def test_postgres_not_postgres
        model = stub
        mock(model).connection { stub }
        assert_nil self.postgres?(model)
      end

      def test_postgres_with_postgres
        klass = Class.new
        Object.const_set 'PostgreSQLAdapter', klass

        model = stub
        mock(model).connection { PostgreSQLAdapter.new }
        assert self.postgres?(model)
      end

      def test_full_search
        assert_equal full_search, false
      end

      def setup_database_models
        @model      = stub
        @table_name = 'table_name'
        @term       = 'term'

        stub(self).source_model  { @model }
        mock(@model).table_name  { @table_name }
        mock(self).source_method { 'column' }
      end
    end
  end
end
