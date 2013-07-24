# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sunspot_suggest/version'

Gem::Specification.new do |spec|
  spec.name          = "sunspot_suggest"
  spec.version       = SunspotSuggest::VERSION
  spec.authors       = ["rainkinz"]
  spec.email         = ["brendan.grainger@gmail.com"]
  spec.description   = %q{Adds suggest and spellcheck DSL methods}
  spec.summary       = %q{Adds suggest and spellcheck DSL methods}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sunspot", "~> 2.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~>2.6.0'
  spec.add_development_dependency 'pry'
end
