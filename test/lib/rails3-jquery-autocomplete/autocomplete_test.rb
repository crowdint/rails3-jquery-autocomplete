require 'test_helper'

module Rails3JQueryAutocomplete
  class AutocompleteTest < Test::Unit::TestCase
    include Rails3JQueryAutocomplete::Autocomplete

    context '#json_for_autocomplete' do
      should 'parse items to JSON' do
        item = mock(Object)
        mock(item).send(:name).times(2) { 'Object Name' }
        mock(item).id { 1 }
        items = [item]
        response = self.json_for_autocomplete(items, :name).first
        assert_equal response["id"], "1"
        assert_equal response["value"], "Object Name"
        assert_equal response["label"], "Object Name"
      end

      context 'with extra data' do
        should 'add that extra data to result' do
          item = mock(Object)
          mock(item).send(:name).times(2) { 'Object Name' }
          mock(item).id { 1 }
          mock(item).send("extra") { 'Object Extra ' }

          items = [item]
          response = self.json_for_autocomplete(items, :name, ["extra"]).first

          assert_equal response["id"], "1"
          assert_equal response["value"], "Object Name"
          assert_equal response["label"], "Object Name"
        end
      end
    end
  end
end
