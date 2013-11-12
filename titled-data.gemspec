# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'titled-data/version'

Gem::Specification.new do |spec|
  spec.name          = "titled-data"
  spec.version       = TitledData::VERSION
  spec.authors       = ["Tower He"]
  spec.email         = ["towerhe@gmail.com"]
  spec.description   = %q{titled-data is a tool to manage a series of data with titles.}
  spec.summary       = %q{titled-data is a tool to manage a series of data with titles.}
  spec.homepage      = "https://github.com/towerhe/titled-data"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
