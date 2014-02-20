require 'test_helper'

module Rails3JQueryAutocomplete
  module Orm
    class ActiveRecordTest < Test::Unit::TestCase
      include Rails3JQueryAutocomplete::Orm::ActiveRecord

      context "#get_autocomplete_order" do
        context 'order is specified' do
          should 'returns that order option' do
            assert_equal "field ASC", active_record_get_autocomplete_order(:field, {:order => 'field ASC'})
          end
        end

        context 'no order is specified' do
          should 'return the order clause by the LOWER(table_name.field) ASC' do
            assert_equal "LOWER(field) ASC", active_record_get_autocomplete_order(:field, {})
          end

          context 'a different model is specified' do
            should 'return the order clause by the LOWER(table_name.field) ASC' do
              model = Object.new
              mock(model).table_name { 'table_name' }
              assert_equal "LOWER(table_name.field) ASC", active_record_get_autocomplete_order(:field, {}, model)
            end
          end
        end
      end

      context '#active_record_get_autocomplete_items' do
        should 'retrieve the items from ActiveRecord' do
          class Dog ; end

          model = Dog
          scoped = []
          whered = []
          term = 'query'
          method = :field

          options = {
            :model => model,
            :term => term,
            :method => method,
            :options => {}
          }

          mock(self).get_autocomplete_limit(anything) { 10 }
          mock(self).active_record_get_autocomplete_order(anything, anything, anything) { "order ASC" }
          mock(self).get_autocomplete_select_clause(model, method, {}) { ["field"] }
          mock(self).get_autocomplete_where_clause(model, term, method, {}) { ["WHERE something"] }
          mock(model).table_name.times(any_times) { 'model_table_name' }

          mock(model).scoped { model }
          mock(model).select(["field"]) { model }
          mock(model).where(["WHERE something"]).mock!.limit(10).mock!.
              order("order ASC") { 1 }

          assert_equal 1, active_record_get_autocomplete_items(options)
        end

        should 'use hstore method if present' do
          class Dog ; end

          model = Dog
          scoped = []
          whered = []
          term = 'query'
          method = :field
          hsmethod = :hsfield

          options = {
            :model => model,
            :term => term,
            :method => method,
            :options => {hstore: {method: hsmethod}}
          }

          mock(self).get_autocomplete_limit(anything) { 10 }
          mock(self).active_record_get_autocomplete_order(anything, anything, anything) { "order ASC" }
          mock(self).get_autocomplete_select_clause(model, hsmethod, options[:options]) { ["hsfield"] }
          mock(self).get_autocomplete_where_clause(model, term, hsmethod, options[:options]) { ["WHERE something"] }
          mock(model).table_name.times(any_times) { 'model_table_name' }

          mock(model).scoped { model }
          mock(model).select(["hsfield"]) { model }
          mock(model).where(["WHERE something"]).mock!.limit(10).mock!.
              order("order ASC") { 1 }

          assert_equal 1, active_record_get_autocomplete_items(options)
        end
      end

      context '#get_autocomplete_select_clause' do
        setup do
          @model = Object.new
          mock(@model).table_name  { 'table_name' }
          mock(@model).primary_key { 'id' }
        end

        should 'create a select clause' do
          assert_equal ["table_name.id", "table_name.method"],
              get_autocomplete_select_clause(@model, :method, {})
        end

        should 'create a select clause with hstore method' do
          assert_equal ["table_name.id", "table_name.hsmethod"],
              get_autocomplete_select_clause(@model, :hsmethod, {hstore: {method: :hsmethod}})
        end

        context 'with extra options' do
          should 'return those extra fields on the clause' do
            options = {:extra_data => ['table_name.created_at']}

            assert_equal ["table_name.id", "table_name.method", "table_name.created_at"],
                get_autocomplete_select_clause(@model, :method, options)
          end
        end
      end

      context '#get_autocomplete_where_clause' do
        setup do
          @model = Object.new
          mock(@model).table_name { 'table_name' }

          @term = 'query'
          @options = {}
          @method = :method
        end

        context 'Not Postgres' do
          should 'return options for where' do
            mock(self).postgres?(@model) { false }
            assert_equal ["LOWER(table_name.method) LIKE ?", "query%"], get_autocomplete_where_clause(@model, @term, @method, @options)
          end
        end

        context 'Postgres' do
          should 'return options for where with ILIKE' do
            mock(self).postgres?(@model) { true }
            assert_equal ["LOWER(table_name.method) ILIKE ?", "query%"], get_autocomplete_where_clause(@model, @term, @method, @options)
          end
        end

        context 'HStore' do
          should 'return options for where from hstore options' do
            mock(self).postgres?(@model) { true }
            @options[:hstore] = {method: :hsmethod, key: :hskey}
            @method = :hsmethod
            assert_equal ["LOWER(table_name.hsmethod -> 'hskey') LIKE ?", "query%"], get_autocomplete_where_clause(@model, @term, @method, @options)
          end
        end

        context 'full search' do
          should 'return options for where with the term sourrounded by %%' do
            mock(self).postgres?(@model) { false }
            @options[:full] = true
            assert_equal ["LOWER(table_name.method) LIKE ?", "%query%"], get_autocomplete_where_clause(@model, @term, @method, @options)
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
