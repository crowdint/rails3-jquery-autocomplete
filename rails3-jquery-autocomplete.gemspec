# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails3-jquery-autocomplete/version"

Gem::Specification.new do |s|
  s.name = %q{rails3-jquery-autocomplete}
  s.version = Rails3JQueryAutocomplete::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["David Padilla"]
  s.email = %q{david.padilla@crowdint.com}
  s.homepage = %q{http://github.com/crowdint/rails3-jquery-autocomplete}
  s.summary = %q{Use jQuery's autocomplete plugin with Rails 3.}
  s.description = %q{Use jQuery's autocomplete plugin with Rails 3.}

  s.add_dependency('rails', '~>3.0')
  s.add_dependency('yajl-ruby')

  s.add_development_dependency('sqlite3-ruby')
  s.add_development_dependency('mongoid', '>= 2.0.0')
  s.add_development_dependency('mongo_mapper', '>= 0.9')
  s.add_development_dependency('bson_ext', '~>1.3.0')
  s.add_development_dependency('shoulda', '~>2.11.1')
  s.add_development_dependency('uglifier')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

