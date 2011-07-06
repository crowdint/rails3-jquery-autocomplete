require 'test_helper'
require 'generators/autocomplete/uncompressed_generator'

module Autocomplete
  class UncompressedGeneratorTest < Test::Unit::TestCase
    def setup
      @destination = File.join('tmp', 'test_app')
      @source      = UncompressedGenerator.source_root
      @filename    = File.join(@destination, 'public', 'javascripts', 'autocomplete-rails.js')

      File.unlink(@filename) if File.exists?(@filename)

      UncompressedGenerator.start([], :destination_root => @destination)
    end

    def test_install
      assert File.exists?(@filename)

      assert_equal(
          File.read(File.join(@source, 'autocomplete-rails-uncompressed.js')),
          File.read(@filename)
      )
    end
  end
end
