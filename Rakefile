require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

task :default => :test

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end
