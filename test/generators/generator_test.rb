require 'test_helper'
require 'generators/autocomplete_generator'

class AutocompleteGeneratorTest < Test::Unit::TestCase
  def setup
    @destination = File.join('tmp', 'test_app')
    @source = AutocompleteGenerator.source_root

    AutocompleteGenerator.start('', :destination_root => @destination)
  end

  def test_install
    assert File.exists?(
      File.join(@destination, 'public', 'javascripts', 'autocomplete-rails.js')
    )

    assert_equal(
      File.read(File.join(@source, 'autocomplete-rails.js')),
      File.read(File.join(@destination, 'public', 'javascripts', 'autocomplete-rails.js'))
    )
  end
end
