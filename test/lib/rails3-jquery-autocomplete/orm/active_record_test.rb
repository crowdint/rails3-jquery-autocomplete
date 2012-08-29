require 'test_helper'

module Rails3JQueryAutocomplete
  module Orm
    class ActiveRecordTest < Test::Unit::TestCase
      include Rails3JQueryAutocomplete::Orm::ActiveRecord
      include Rails3JQueryAutocomplete::Controller

      context "#source_model" do
        should 'return the specified source object as a class' do
          @autocomplete_object = :object
          assert_equal source_model  , Object
          assert_kind_of source_model, Class
        end
      end

      context "#source_method" do
        should 'return the specified source object method as a symbol' do
          @autocomplete_method = :method
          assert_equal source_method, :method
        end
      end

      context "#order" do
        should 'return a default order clause for ActiveRecord' do
          mock(self).source_model.stub!.table_name { 'table' }
          mock(self).source_method { 'method' }
          assert_equal order, 'table.method ASC'
        end
      end

      context "#items" do
        should 'return the AR objects based on the specified term' do
          active_record_scope, result = stub, stub

          terms = 'terms'
          expected_where = "WHERE table.column LIKE '%terms'"
          expected_order = "ORDER BY table.column ASC"

          mock(source_model).scoped { active_record_scope }

          mock(self).where_clause(terms) { expected_where }
          mock(self).order { expected_order }

          mock(active_record_scope).where(expected_where).mock!.limit(10).
              mock!.order(expected_order) { result }

          assert_equal items(terms), result
        end
      end

      context "#where_clause" do
        setup do
          @model      = stub
          @table_name = 'table_name'
          @term       = 'term'

          stub(self).source_model  { @model }
          mock(@model).table_name  { @table_name }
          mock(self).source_method { 'column' }
        end

        context "postgres" do
          should 'return a WHERE clause constructed with specified term, table and column using ILIKE' do
            mock(self).postgres?(@model) { true }

            assert_equal where_clause(@term), ['LOWER(table_name.column) ILIKE ?', '%term%']
          end
        end

        context "else" do
          should 'return a WHERE clause constructed with specified term, table and column using LIKE' do
            mock(self).postgres?(@model) { false }

            assert_equal where_clause(@term), ['LOWER(table_name.column) LIKE ?', '%term%']
          end
        end
      end

      context '#postgres?' do
        setup do
          @model = stub
        end

        context 'the connection class is not postgres' do
          setup do
            mock(@model).connection { stub }
          end

          should 'return nil if the connection class matches PostgreSQLAdapter' do
            assert_nil self.postgres?(@model)
          end
        end

        context 'the connection class matches PostgreSQLAdapter' do
          setup do
            class PostgreSQLAdapter; end
            mock(@model).connection { PostgreSQLAdapter.new }
          end

          should 'return true' do
            assert self.postgres?(@model)
          end
        end
      end
    end
  end
end
