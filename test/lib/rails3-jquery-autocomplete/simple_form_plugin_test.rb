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

    should "add a data-update-elements attribute with encoded data if passed an :update_elements option" do
      with_input_for @user, :name, :autocomplete, :update_elements => { :id => '#this', :ego => '#that' }
      assert_select "input#user_name[data-update-elements='{&quot;id&quot;:&quot;#this&quot;,&quot;ego&quot;:&quot;#that&quot;}']"
    end

    should "not add a data-update-elements attribute if not passed an :update_elements option" do
      with_input_for @user, :name, :autocomplete, :url => '/test'
      assert_no_select "input#user_name[data-update-elements]"
    end

    should "add arbitrary html options, if specified" do
      with_input_for @user, :name, :autocomplete, :input_html => { :class => "superego" }
      assert_select "input#user_name.superego"
    end

  end
end
