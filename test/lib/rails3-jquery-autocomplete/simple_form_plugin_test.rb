require 'test_helper'
require 'view_test_helper'

module Rails3JQueryAutocomplete
  class SimpleFormPluginTest < ActionView::TestCase

    should "apply a class of 'autocomplete'" do
      with_input_for @user, :name, :autocomplete
      assert_select "input#user_name.autocomplete[type=text][name='user[name]']"
    end

    should "add a data-autocomplete attribute with the provided :url" do
      with_input_for @user, :name, :autocomplete, :url => '/test'
      assert_select "input#user_name[data-autocomplete=/test]"
    end

    should "not add a data-update-elements attribute if not passed an :update_elements option" do
      with_input_for @user, :name, :autocomplete, :url => '/test'
      assert_no_select "input#user_name[data-update-elements]"
    end

  end
end
