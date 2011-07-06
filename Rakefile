require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
require 'rcov/rcovtask'

task :default => [:uglify, :test]

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :uglify do
  require 'uglifier'
  file_folder = "lib/generators/templates"
  File.open("#{file_folder}/autocomplete-rails.js", "w") do |f|
    f << Uglifier.compile(File.read("#{file_folder}/autocomplete-rails-uncompressed.js"))
  end
end

Rcov::RcovTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.rcov_opts = %w{--exclude \/gems\/}
  t.verbose = true
end
