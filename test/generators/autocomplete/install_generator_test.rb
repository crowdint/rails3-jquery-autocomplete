require 'test_helper'
require 'generators/autocomplete/install_generator'

module Autocomplete
  class InstallGeneratorTest < Test::Unit::TestCase
    def setup
      @destination = File.join('tmp', 'test_app')
      @source      = InstallGenerator.source_root
      @filename    = File.join(@destination, 'public', 'javascripts', 'autocomplete-rails.js')

      File.unlink(@filename) if File.exists?(@filename)

      InstallGenerator.start([], :destination_root => @destination)
    end

    def test_install
      assert File.exists?(@filename)

      assert_equal(
          File.read(File.join(@source, 'autocomplete-rails.js')),
          File.read(@filename)
      )
    end
  end
end
