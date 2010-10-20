require 'test_helper'
require 'rails3-jquery-autocomplete-helpers'

module Rails3JQueryAutocomplete
  module Test

    class HelpersTest < ::Test::Unit::TestCase

      assert_structure = lambda do |hash|
        assert_instance_of(String, hash['label'])
        assert_instance_of(String, hash['value'])
      end

      context 'passing a Mongoid query result' do

        require 'support/mongoid'
        include Rails3JQueryAutocomplete::Mongoid::Test
   
        should 'parse items to JSON' do
          response = Helpers.json_for_autocomplete(Game.all, :name)
          assert_not_nil(response)
          response.each(&assert_structure)
        end

      end

      context 'passing an ActiveRecord query result' do

        require 'support/active_record'
        include Rails3JQueryAutocomplete::ActiveRecord::Test
   
        should 'parse items to JSON' do
          response = Helpers.json_for_autocomplete(Game.all, :name)
          assert_not_nil(response)
          response.each(&assert_structure)
        end
      end

      context 'converting a symbol to connstant' do
        should 'return a defined constant' do
          ::MyJustDefinedConstant = Class.new
          assert_equal(::MyJustDefinedConstant, Helpers.get_object(:my_just_defined_constant))
        end
      end

      context 'returning one symbol for an implemented adapter' do
        require 'support/active_record'
        require 'support/mongoid'
        should 'return a symbol for defined interface' do
          assert_equal(:activerecord, Helpers.get_implementation(::Movie))
          assert_equal(:mongoid, Helpers.get_implementation(::Game))
        end
      end

      context 'returning a limit integer number' do
        should 'return default value of 10' do
          assert_equal(10, Helpers.get_limit({}))
        end

        should 'return params value' do
          assert_equal(1, Helpers.get_limit(:limit => 1))
        end
      end

      context 'returning elements ordering' do
        should 'returning default ascending order for activerecord' do
          assert_equal("name ASC", Helpers.get_order(:activerecord, 'name', {}))
        end

        should 'returning descending order for activerecord' do
          assert_equal("thisfield DESC", Helpers.get_order(:activerecord, 'otherfield', :order => 'thisfield DESC'))
        end

        should 'returning default ascending order for mongoid' do
          expected = [[:name, :asc]]
          returned = Helpers.get_order(:mongoid, 'name', {})
          assert expected.eql?(returned)
        end

        should 'returning order according paramters for mongoid' do
          expected = [[:first, :asc], [:second, :desc]]
          returned = Helpers.get_order(:mongoid, 'name', {:order => 'first asc, second desc'})
          assert expected.eql?(returned)
        end

      end
 
    end
  end
end
