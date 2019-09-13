# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zenv'

Gem::Specification.new do |spec|
  spec.name          = "zenv"
  spec.version       = Zenv.version
  spec.authors       = ["Austin Schneider"]
  spec.email         = ["me@austinschneider.com"]

  spec.summary       = 'ZEN ENV'
  spec.description   = 'Simple and flexible approach to loading environment variables.'
  spec.homepage      = 'https://github.com/austinthecoder/zenv'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "rspec", "~> 3"
end
