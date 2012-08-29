require 'test_helper'

module Rails3JQueryAutocomplete
  class AutocompleteTest < Test::Unit::TestCase
    include Rails3JQueryAutocomplete::Autocomplete

    autocomplete :object, :name

    should 'define the source_method method' do
      assert_respond_to self, :source_method
      assert_equal source_method, :name
    end

    should 'define the source_model method' do
      assert_respond_to self, :source_model
      assert_equal source_model, Object
    end
  end
end
