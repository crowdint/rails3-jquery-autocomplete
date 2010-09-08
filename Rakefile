require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rails3-jquery-autocomplete"
    gem.summary = %Q{Use jQuery's autocomplete plugin with Rails 3.}
    gem.description = %Q{Use jQuery's autocomplete plugin with Rails 3.}
    gem.email = "david.padilla@crowdint.com"
    gem.homepage = "http://github.com/crowdint/rails3-jquery-autocomplete"
    gem.authors = ["David Padilla"]
    gem.add_development_dependency "rails", ">= 3.0.0"
    gem.files = %w(README.markdown Rakefile) + Dir.glob("{lib,test}/**/*")

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rails3-jquery-autocomplete #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
