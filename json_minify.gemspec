# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_minify/version'

Gem::Specification.new do |spec|
  spec.name          = "json_minify"
  spec.version       = JsonMinify::VERSION
  spec.authors       = ["Geoff Youngs, Alan Cohen"]
  spec.email         = ["git@intersect-uk.co.uk"]
  spec.summary       = %q{JSON.minify implementation}
  spec.description   = %q{Pre-parser for JSON that removes C/C++ style comments
                          and whitespace from formatted JSON, similar to
                          https://github.com/getify/JSON.minify.}
  spec.homepage      = "http://github.com/geoffyoungs/json-minify-rb"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb'] + Dir['spec/*']+ Dir['bin/*.rb']
  spec.executables   = ["json_minify"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "rake", '~> 10.1'
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_dependency "multi_json", "~> 1.0"
end
