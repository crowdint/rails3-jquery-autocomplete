require 'test_helper'
require 'generators/autocomplete/controller_generator'

module Autocomplete
  class ControllerGeneratorTest < Test::Unit::TestCase
    def setup
      @destination = File.join('tmp', 'test_app')
      @source      = ControllerGenerator.source_root
      @filename    = File.join(@destination, 'app', 'controllers', 'autocomplete', 'brand_name_controller.rb')

      File.unlink(@filename) if File.exists?(@filename)

      ControllerGenerator.start(['brand', 'name'], :destination_root => @destination)
    end

    def test_install
      assert File.exists?(@filename)
      assert_match /class BrandNameController < ApplicationController/, File.read(@filename)
      assert_match /autocomplete :brand, :name/, File.read(@filename)
    end
  end
end
