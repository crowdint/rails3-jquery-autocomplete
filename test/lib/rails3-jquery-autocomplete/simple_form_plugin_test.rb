require 'test_helper'
require 'view_test_helper'

module Rails3JQueryAutocomplete
  class SimpleFormPluginTest < ActionView::TestCase
    def test_apply_autocomplete_class
      with_input_for @user, :name, :autocomplete
      assert_select "input#user_name.autocomplete[type=text][name='user[name]']"
    end

    def test_add_data_autocomplete_attribute
      with_input_for @user, :name, :autocomplete, :url => '/test'
      assert_select "input#user_name[data-autocomplete=/test]"
    end

    def test_add_data_update_elements_attribute
      with_input_for @user, :name, :autocomplete, :update_elements => { :id => '#this', :ego => '#that' }
      assert_select "input#user_name[data-update-elements='{&quot;id&quot;:&quot;#this&quot;,&quot;ego&quot;:&quot;#that&quot;}']"
    end

    def test_do_not_add_data_update_elements
      with_input_for @user, :name, :autocomplete, :url => '/test'
      assert_no_select "input#user_name[data-update-elements]"
    end

    def test_arbitrary_html_options
      with_input_for @user, :name, :autocomplete, :input_html => { :class => "superego" }
      assert_select "input#user_name.superego"
    end
  end
end
