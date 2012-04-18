require 'test_helper'
require 'view_test_helper'

module Rails3JQueryAutocomplete
  class SimpleFormPluginTest < ActionView::TestCase

    def setup
      with_input_for @user, :name, :autocomplete, :url => '/test'
    end

    should "apply a class of 'autocomplete'" do
      assert_select "input#user_name.autocomplete[type=text][name='user[name]']"
    end

    should "add a data-autocomplete attribute with the provided :url" do
      assert_select "input#user_name[data-autocomplete=/test]"
    end

  end
end
