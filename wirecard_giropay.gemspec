# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wirecard_giropay/version'

Gem::Specification.new do |spec|
  spec.name          = "wirecard_giropay"
  spec.version       = WirecardGiropay::VERSION
  spec.authors       = ["betterplace developers"]
  spec.email         = ["developers@betterplace.org"]
  spec.summary       = %q{Wirecard Giropay implementation}
  spec.description   = %q{Wirecard Giropay implementation}
  spec.homepage      = ""
  spec.license       = "APACHE 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "typhoeus"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "simplecov"
end
