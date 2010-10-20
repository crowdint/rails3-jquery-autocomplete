require "test_helper"
require 'support/mongoid'

class GamesControllerTest < ActionController::TestCase

  include Rails3JQueryAutocomplete::Mongoid::Test

  context "the autocomplete gem" do

    should "be able to access the autocomplete action regardless of the quality of param[:term]" do
      get :autocomplete_game_name
      assert_response :success

      get :autocomplete_game_name, :term => ''
      assert_response :success

      get :autocomplete_game_name, :term => nil
      assert_response :success

      get :autocomplete_game_name, :term => 'Al'
      assert_response :success
    end

    should "respond with expected json" do
      get :autocomplete_game_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.first["label"], @game.name)
      assert_equal(json_response.first["value"], @game.name)
      assert_equal(json_response.first["id"], @game.id.to_s)
    end

    should "return results in alphabetical order by default" do
      get :autocomplete_game_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.first["label"], "Alpha")
      assert_equal(json_response.last["label"], "Alzpha")
    end

    should "be able to sort in other ways if desired" do
      GamesController.send(:autocomplete, :game, :name, {:order => "name DESC"})

      get :autocomplete_game_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.first["label"], "Alzpha")
      assert_equal(json_response.last["label"], "Alpha")
    end

    should "be able to limit the results" do
      GamesController.send(:autocomplete, :game, :name, {:limit => 1})

      get :autocomplete_game_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.length, 1)
    end

    should "ignore case of search term and results" do
      @game = Game.create(:name => 'aLpHa')

      GamesController.send(:autocomplete, :game, :name)

      get :autocomplete_game_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.length, Game.count)
      assert_equal(json_response.last["label"], 'aLpHa')
    end

    should "match term to letters in middle of words when full-text search is on" do
      GamesController.send(:autocomplete, :game, :name, {:full => true})

      get :autocomplete_game_name, :term => 'ph'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.length, Game.count)
      assert_equal(json_response.first["label"], @game.name)
    end

    should "be able to customize what is displayed" do
      GamesController.send(:autocomplete, :game, :name, {:display_value => :display_name})

      get :autocomplete_game_name, :term => 'Al'

      json_response = JSON.parse(@response.body)

      assert_equal(@game.display_name, json_response.first["label"])
      assert_equal(@game.display_name, json_response.first["value"])
      assert_equal(@game.id.to_s, json_response.first["id"])
    end
  end
end
