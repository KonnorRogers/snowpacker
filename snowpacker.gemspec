# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "snowpacker/version"

Gem::Specification.new do |spec|
  spec.name = "snowpacker"
  spec.version = Snowpacker::VERSION
  spec.authors = ["Konnor Rogers"]
  spec.email = ["konnor7414@gmail.com"]

  spec.summary = "Rails integration of Snowpack"
  spec.description = "Rails integration of Snowpack"
  spec.homepage = "http://github.com/paramagicdev/snowpacker"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rack-proxy", "~> 0.6.4"
  spec.add_runtime_dependency "rake", "~> 13.0"

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "conventional-changelog", "~> 1.2"
  spec.add_development_dependency "minitest", "~> 5.14"
  spec.add_development_dependency "pry", "~> 0.12"
  spec.add_development_dependency "rails", "~> 6.0"
  spec.add_development_dependency "standardrb", "~> 1.0"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "minitest-reporters", "~> 1.4"
end
