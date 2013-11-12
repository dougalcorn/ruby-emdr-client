# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emdr/version'

Gem::Specification.new do |spec|
  spec.name          = "emdr"
  spec.version       = Emdr::VERSION
  spec.authors       = ["Doug Alcorn"]
  spec.email         = ["dougalcorn@gmail.com"]
  spec.description   = %q{Very basic client for the Eve Market Data Relay ZeroMQ network}
  spec.summary       = %q{Simple EMDR client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
