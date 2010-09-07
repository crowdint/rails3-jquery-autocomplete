require "test_helper"

class FormHelperTest < ActionView::TestCase
  def test_text_field_tag
    assert_match(/data-autocomplete=\"some\/path\"/, text_field_tag('field_name', '', :autocomplete => 'some/path'))
  end
  
  def test_text_field
    assert_match(/data-autocomplete=\"some\/path\"/, text_field('field_name', '', :autocomplete => 'some/path'))
  end
end