# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails3-jquery-autocomplete}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Padilla"]
  s.date = %q{2010-07-15}
  s.description = %q{Use jQuery's autocomplete plugin with Rails 3.}
  s.email = %q{david@crowdint.com}
  s.extra_rdoc_files = ["README.markdown", "lib/autocomplete.rb", "lib/generators/autocomplete_generator.rb", "lib/generators/templates/autocomplete-rails.js"]
  s.files = ["README.markdown", "Rakefile", "lib/autocomplete.rb", "lib/generators/autocomplete_generator.rb", "lib/generators/templates/autocomplete-rails.js", "Manifest", "rails3-jquery-autocomplete.gemspec"]
  s.homepage = %q{http://github.com/crowdint/rails3-jquery-autocomplete}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Rails3-jquery-autocomplete", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rails3-jquery-autocomplete}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Use jQuery's autocomplete plugin with Rails 3.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
