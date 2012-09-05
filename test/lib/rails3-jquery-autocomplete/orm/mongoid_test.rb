require 'test_helper'

module Rails3JQueryAutocomplete
  module Orm
    class MongoidTest < Test::Unit::TestCase
      include Rails3JQueryAutocomplete::Orm::Mongoid
      include Rails3JQueryAutocomplete::Controller

      def test_order
        mock(self).source_method { :method }
        assert_equal [[:method, :asc]], order
      end

      def test_where_clause
        mock(self).source_method { :method }
        query_hash = { :method => /^term/i }
        assert_equal query_hash, where_clause('term')
      end

      def test_items
        result, model, stub_where, stub_order = stub, stub, stub, stub
        mock(self).source_model  { model }
        mock(self).where_clause('term') { stub_where }
        mock(self).order { stub_order }

        mock(model).where(stub_where).mock!.limit(10).mock!.order_by(stub_order) { result }

        assert_equal result, items('term')
      end
    end
  end
end
