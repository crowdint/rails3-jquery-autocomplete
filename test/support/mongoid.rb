class Character
  include Mongoid::Document
  field :name, :class => String
  referenced_in :game
end

class Game
  include Mongoid::Document
  field :name, :class => String
  references_one :character
  def display_name
    "Game: #{name}"
  end
end

class GamesController < ActionController::Base
  autocomplete :game, :name                       
end        

module Rails3JQueryAutocomplete
  module Test
    module Mongoid
      def setup
        ::Mongoid.configure do |config|
          name = "rails3_jquery_autocomplete_test"
          host = "localhost"
          config.master = Mongo::Connection.new.db(name)
          config.logger = nil
        end

        @game = Game.create(:name => 'Alpha')
        @game2 = Game.create(:name => 'Alspha')
        @game3 = Game.create(:name => 'Alzpha')
      end

      def teardown
        ::Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
      end
    end
  end
end
