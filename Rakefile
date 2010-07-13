require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('rails3-jquery-autocomplete', '0.1.0') do |p|
  p.description    = "Use jQuery's autocomplete plugin with Rails 3."
  p.url            = "http://github.com/crowdint/rails3-jquery-autocomplete"
  p.author         = "David Padilla"
  p.email          = "david@crowdint.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }