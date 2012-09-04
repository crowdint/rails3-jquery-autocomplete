require 'test_helper'

module Rails3JQueryAutocomplete
  class ControllerTest < Test::Unit::TestCase
    include Rails3JQueryAutocomplete::Autocomplete
    include Rails3JQueryAutocomplete::Controller
    autocomplete :brand, :name

    def test_show_action
      stub(self).params { { :term => 'query' } }
      mock(self).items_to_json('query') { '[ SOME JSON ]' }
      mock(self).render :json => '[ SOME JSON ]'
      show
    end

    def test_limit
      assert_equal limit, 10
    end

    def test_items_to_json
      item = stub
      stub(item).id            { 1 }
      stub(self).source_method { :some_method }
      stub(item).some_method   { 'method result' }

      mock(self).items('term') { [ item ] }

      assert_equal items_to_json('term'), [{"id"=>"1", "label"=>"method result", "value"=>"method result"}]
    end

    def test_sym_to_class
      assert_equal sym_to_class(:object), Object
    end
  end
end
