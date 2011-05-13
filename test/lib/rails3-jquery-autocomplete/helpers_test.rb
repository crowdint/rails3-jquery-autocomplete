require 'test_helper'

module Rails3JQueryAutocomplete
  module Test
    class HelpersTest < ::Test::Unit::TestCase
      include Rails3JQueryAutocomplete::Helpers

        context 'passing a query result' do
          should 'parse items to JSON' do
            response = self.json_for_autocomplete([], :name)
            assert_not_nil(response)
          end
        end
    end
  end
end
