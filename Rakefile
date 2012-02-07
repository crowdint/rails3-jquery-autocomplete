require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

task :default => [:uglify, :test]

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :uglify do
  require 'uglifier'
  file_folder = "lib/assets/javascripts"
  File.open("#{file_folder}/autocomplete-rails.js", "w") do |f|
    f << Uglifier.compile(File.read("#{file_folder}/autocomplete-rails-uncompressed.js"))
  end
end

