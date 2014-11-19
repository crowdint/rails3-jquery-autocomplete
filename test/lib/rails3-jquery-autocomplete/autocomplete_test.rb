require 'test_helper'

module Rails3JQueryAutocomplete
  class AutocompleteTest < Test::Unit::TestCase
    include Rails3JQueryAutocomplete::Autocomplete

    context 'ClassMethods' do
      context '#autocomplete' do
        context '#get_prefix' do
          context 'Mongoid and MongoMapper is not defined' do
            setup do
              ActorsController = Class.new(ActionController::Base)
              ActorsController.autocomplete(:movie, :name)
              @controller = ActorsController.new

              @model = Class.new(ActiveRecord::Base)

              Object.send(:remove_const, :Mongoid)
              Object.send(:remove_const, :MongoMapper)
            end

            should 'not raise exception' do
              @controller.get_prefix(@model)
            end
          end
        end
      end
    end

    context '#get_autocomplete_limit' do
      context 'the limit option was specified' do
        should "return the limit option" do
          assert_equal 99, get_autocomplete_limit({:limit => 99})
        end
      end

      context 'the limit option is not specified' do
        should 'return 10' do
          assert_equal 10, get_autocomplete_limit({})
        end
      end
    end

    context '#get_object' do
      should 'return the specified sym as a class name' do
        symbol = Object.new
        class_object = Class.new
        mock(symbol).to_s.mock!.camelize.mock!.constantize { class_object }
        assert_equal class_object, get_object(symbol)
      end
    end

    context '#json_for_autocomplete' do
      should 'parse items to JSON' do
        item = mock(Object)
        mock(item).send(:name).times(2) { 'Object Name' }
        mock(item).id { 1 }
        items    = [item]
        response = self.json_for_autocomplete(items, :name).first
        assert_equal response["id"], "1"
        assert_equal response["value"], "Object Name"
        assert_equal response["label"], "Object Name"
      end

      context 'with extra data' do
        should 'add that extra data to result' do
          item = mock(Object)
          mock(item).send(:name).times(2) { 'Object Name' }
          mock(item).id { 1 }
          mock(item).send("extra") { 'Object Extra ' }

          items    = [item]
          response = self.json_for_autocomplete(items, :name, ["extra"]).first

          assert_equal "1"           , response["id"]
          assert_equal "Object Name" , response["value"]
          assert_equal "Object Name" , response["label"]
        end
      end
    end
  end
end
