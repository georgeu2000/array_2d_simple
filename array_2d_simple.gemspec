# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'array_2d_simple/version'

Gem::Specification.new do |gem|
  gem.name          = "array_2d_simple"
  gem.version       = Array2dSimple::VERSION
  gem.authors       = ["George Ulmer"]
  gem.email         = ["george@boost-media.com"]
  gem.description   = %q{Implementation of 2D array}
  gem.summary       = %q{Implementation of 2D array}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
