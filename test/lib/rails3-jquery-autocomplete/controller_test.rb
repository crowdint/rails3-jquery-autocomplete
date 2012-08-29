require 'test_helper'

module Rails3JQueryAutocomplete
  class ControllerTest < Test::Unit::TestCase
    include Rails3JQueryAutocomplete::Autocomplete
    include Rails3JQueryAutocomplete::Controller
    autocomplete :brand, :name

    context "#show" do
      should 'render the resulting JSON from items_to_json' do
        stub(self).params { { :term => 'query' } }
        mock(self).items_to_json('query') { '[ SOME JSON ]' }
        mock(self).render :json => '[ SOME JSON ]'
        show
      end
    end

    context "#limit" do
      should 'return 10' do
        assert_equal limit, 10
      end
    end

    context "#items_to_json" do
      should "convert all items into JSON for the autocomplete plugin" do
        item = stub
        stub(item).id            { 1 }
        stub(self).source_method { :some_method }
        stub(item).some_method   { 'method result' }

        mock(self).items('term') { [ item ] }

        assert_equal items_to_json('term'), [{"id"=>"1", "label"=>"method result", "value"=>"method result"}]
      end
    end

    context "#sym_to_class" do
    	should "convert the specified sym to a contstant" do
    		assert_equal sym_to_class(:object), Object
    	end
    end
  end
end
