class User
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :id, :name, :description, :created_at, :updated_at

  def initialize(options={})
    @new_record = false
    options.each do |key, value|
      send("#{key}=", value)
    end if options
  end

  def new_record!
    @new_record = true
  end

  def persisted?
    !@new_record
  end
end

class MockController
  attr_writer :action_name

  def _routes
    self
  end

  def action_name
    defined?(@action_name) ? @action_name : "edit"
  end

  def url_for(*args)
    "http://example.com"
  end

  def url_helpers
    self
  end

  def hash_for_user_path(*args); end
  def hash_for_users_path(*args); end
end

class MockResponse

  def initialize(test_case)
    @test_case = test_case
  end

  def content_type
    'text/html'
  end

  def body
    @test_case.send :output_buffer
  end
end

class ActionView::TestCase
  include Rails3JQueryAutocomplete::Autocomplete
  include SimpleForm::ActionViewExtensions::FormHelper

  setup :set_controller
  setup :set_response
  setup :setup_new_user

  def assert_no_select(selector, value = nil)
    assert_select(selector, :text => value, :count => 0)
  end

  def with_concat_form_for(*args, &block)
    concat simple_form_for(*args, &block)
  end

  def with_input_for(object, attribute_name, type, options={})
    with_concat_form_for(object) do |f|
      f.input(attribute_name, options.merge(:as => type))
    end
  end

  def set_controller
    @controller = MockController.new
  end

  def set_response
    @response = MockResponse.new(self)
  end

  def setup_new_user
    @user = User.new(
      :id => 1,
      :name => 'New in SimpleForm!',
      :description => 'Hello!',
      :created_at => Time.now
    )
  end

  def protect_against_forgery?
    false
  end

  def user_path(*args)
    '/users'
  end
  alias :users_path :user_path
end
