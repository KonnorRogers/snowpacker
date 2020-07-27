# frozen_string_literal: true

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', "README.md"]   # optional
  t.options = ['--title Snowpacker #{Snowpacker::VERSION}', '--line-numbers', '--any', '--extra', '--opts'] # optional
  t.stats_options = ['--list-undoc']         # optional
end

require "bundler/gem_tasks"

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

task default: :test
