# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'image-4ye/version'

Gem::Specification.new do |spec|
  spec.name          = "image-4ye"
  spec.version       = Image4ye::VERSION
  spec.authors       = ["Kaid"]
  spec.email         = ["kaid@kaid.me"]
  spec.summary       = %q{img.4ye.me API wrapper}
  spec.description   = %q{Uploading and retrieving images on img.4ye.me.}
  spec.homepage      = "https://github.com/mindpin/image-4ye"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 1.7.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
