require 'test_helper'

module Rails3JQueryAutocomplete
  class AutocompleteTest < Test::Unit::TestCase
    include Rails3JQueryAutocomplete::Autocomplete

    autocomplete :object, :name

    def test_source_method
      assert_respond_to self, :source_method
      assert_equal source_method, :name
    end

    def test_defines_source_model
      assert_respond_to self, :source_model
      assert_equal source_model, Object
    end
  end
end
