# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yoyo/version'

Gem::Specification.new do |spec|
  spec.name          = "yoyo"
  spec.version       = Yoyo::VERSION
  spec.authors       = ["Phil Crissman", "Jonah Honeyman"]
  spec.email         = ["phil.crissman@gmail.com"]
  spec.summary       = %q{A ruby gem for using the YO API}
  spec.description   = %q{It's a ruby gem for using the YO API. You need to get an API Token, okay?}
  spec.homepage      = "https://github.com/philcrissman/yoyo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
  spec.add_dependency "faraday"
end
