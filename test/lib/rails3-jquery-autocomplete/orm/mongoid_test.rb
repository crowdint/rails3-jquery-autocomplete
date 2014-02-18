require 'test_helper'

module Rails3JQueryAutocomplete
	module Orm
		class MongoidTest < Test::Unit::TestCase
			include Rails3JQueryAutocomplete::Orm::Mongoid

			context "#mongoid_get_autocomplete_order" do
				context "order is specified" do
					should 'returns the parametrized order for Mongoid' do
						assert_equal [[:field, :asc], [:state, :desc]],
              mongoid_get_autocomplete_order(:method, :order => 'field ASC, state DESC')
					end
				end

				context 'order is not specified' do
					should 'return the method ordered ASC by default' do
						assert_equal [[:method, :asc]],
              mongoid_get_autocomplete_order(:method, {})
					end
				end
			end

			context "#mongoid_get_autocomplete_items" do
				setup do
					@model = mock(Object)

					@parameters = {
						:model => @model,
						:method => :field,
						:term => 'query',
						:options => {:full => false}
					}
					mock(self).get_autocomplete_limit(anything) { 10 }
					mock(self).mongoid_get_autocomplete_order(anything, anything) { [[:order, :asc]] }
				end

				context 'not a full search' do
					should 'do stuff' do
						mock(@model).where({:field=>/^query/i}).mock!.limit(10).
								mock!.order_by([[:order, :asc]])

            mongoid_get_autocomplete_items(@parameters)
					end
				end

				context 'full search' do
					should 'return a full search query' do
						@parameters[:options] = {:full => true}

						mock(@model).where({:field=>/.*query.*/i}).mock!.limit(10).
								mock!.order_by([[:order, :asc]])

            mongoid_get_autocomplete_items(@parameters)
					end
				end
			end
		end
	end
end
