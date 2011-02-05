require "test_helper"

class Post
  attr_accessor :author
end

class FormHelperTest < ActionView::TestCase
  def test_text_field_tag
    assert_match(/autocomplete=\"some\/path\"/, text_field_tag('field_name', '', :autocomplete => 'some/path'))
  end

  def test_text_field
    post = Post.new
    assert_match(/autocomplete=\"some\/path\"/, text_field(:post, :author, :autocomplete => 'some/path'))
  end

  def test_autocomplete_field_tag
    assert_match(/data-autocomplete=\"some\/path\"/, autocomplete_field_tag('field_name', '', 'some/path'))
  end

  def test_autocomplete_field
    post= Post.new
    assert_match(/data-autocomplete=\"some\/path\"/, autocomplete_field(:post, :author, 'some/path'))
  end
end
