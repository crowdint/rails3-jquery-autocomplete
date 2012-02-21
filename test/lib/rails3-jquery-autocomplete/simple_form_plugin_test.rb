require 'test_helper'
require 'view_test_helper'

module Rails3JQueryAutocomplete
  class SimpleFormPluginTest < ActionView::TestCase

    context '#autocomplete_field' do
      should "not include :update_options if not specifically set" do
        with_concat_form_for(@user) do |f|
          f.input :name, url: '/test', as: :autocomplete
        end
        assert_tag "input", attributes: {
          :id                 => 'user_name',
          :name               => "user[name]",
          :size               => '30',
          :type               => 'text',
          :value              => @user.name,
          'data-autocomplete' => '/test',
          :class              => 'autocomplete optional'
        }
      end
    end

  end
end
