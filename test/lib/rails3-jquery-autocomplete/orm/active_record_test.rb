require 'test_helper'

module Rails3JQueryAutocomplete
	module Orm
		class ActiveRecordTest < Test::Unit::TestCase
			include Rails3JQueryAutocomplete::Orm::ActiveRecord

			context "#get_autocomplete_order" do
				context 'order is specified' do
					should 'returns that order option' do
						assert_equal "field ASC", get_autocomplete_order(:field, {:order => 'field ASC'})
					end
				end

				context 'no order is specified' do
					should 'return the order clause by the field ASC' do
						assert_equal "field ASC", get_autocomplete_order(:field, {})
					end	

					context 'a different model is specified' do
						should 'return the order clause by the table_name.field ASC' do
							model = Object.new
							mock(model).table_name { 'table_name' }
							assert_equal "table_name.field ASC", get_autocomplete_order(:field, {}, model)
						end	
					end
				end
			end

			context '#get_autocomplete_items' do
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
					mock(self).get_autocomplete_order(anything, anything, anything) { "order ASC" }
					mock(self).get_autocomplete_select_clause(model, method, {}) { ["field"] }
					mock(self).get_autocomplete_where_clause(model, term, method, {}) { ["WHERE something"] }
					mock(model).table_name.times(any_times) { 'model_table_name' }

					mock(model).scoped { model }
					mock(model).select(["field"]) { model }
					mock(model).where(["WHERE something"]).mock!.limit(10).mock!.
							order("order ASC") { 1 }

					assert_equal 1, get_autocomplete_items(options)
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
					mock(@model).table_name  { 'table_name' }

					@term = 'query'
					@options = {}
					@method = :method
				end

				context 'Not Postgres' do
					should 'return options for where' do
						mock(self).postgres? { false }
						assert_equal ["LOWER(table_name.method) LIKE ?", "query%"], get_autocomplete_where_clause(@model, @term, @method, @options)
					end
				end

				context 'Postgres' do
					should 'return options for where with ILIKE' do
						mock(self).postgres? { true }
						assert_equal ["LOWER(table_name.method) ILIKE ?", "query%"], get_autocomplete_where_clause(@model, @term, @method, @options)
					end
				end

				context 'full search' do
					should 'return options for where with the term sourrounded by %%' do
						mock(self).postgres? { false }
						@options[:full] = true
						assert_equal ["LOWER(table_name.method) LIKE ?", "%query%"], get_autocomplete_where_clause(@model, @term, @method, @options)
					end
				end
			end

			context '#postgres?' do
				should 'return nil if PGConn is not defined' do
					assert_nil self.postgres?
				end

				should 'return true if PGConn is defined' do
					class ::PGConn ; end

					assert self.postgres?
				end
			end
		end
	end
end
