module Rails3JQueryAutocomplete
  module Test
    module ActiveRecord
      def setup
        ::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
        ::ActiveRecord::Schema.define(:version => 1) do
          create_table :movies do |t|
            t.column :name, :string
          end

          create_table :actors do |t|
            t.column :movie_id, :integer
            t.column :name, :string
          end
        end

        @actor_class = Object.const_set(:Actor, Class.new(::ActiveRecord::Base))
        @actor_class.belongs_to(:movie)

        @movie_class = Object.const_set(:Movie, Class.new(::ActiveRecord::Base))
        @movie_class.class_eval do
          def display_name
            "Movie: #{name}"
          end
        end

        @controller = ActorsController.new

        @movie1  = @movie_class.create(:name => 'Alpha')
        @movie2 = @movie_class.create(:name => 'Alspha')
        @movie3 = @movie_class.create(:name => 'Alzpha')
      end

      def teardown
        Object.send(:remove_const, :Actor)
        Object.send(:remove_const, :Movie)
        ::ActiveRecord::Base.connection.tables.each do |table|
          ::ActiveRecord::Base.connection.drop_table(table)
        end
      end
    end
  end
end
