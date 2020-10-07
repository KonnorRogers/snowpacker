# frozen_string_literal: true

require "snowpacker"

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

require "yard"

YARD::Rake::YardocTask.new do |t|
  t.files = ["lib/**/*.rb", "README.md"] # optional
  t.options = ["--title Snowpacker #{::Snowpacker::VERSION}", "--line-numbers", "--any", "--extra", "--opts"] # optional
  t.stats_options = ["--list-undoc"] # optional
end

require "bundler/gem_tasks"

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = Dir["test/**/*_test.rb"].reject do |path|
    path.include?("rails_test_app") || path.include?("ruby_test_app")
  end
  t.verbose = true
end

Rake::TestTask.new(:"test:unit") do |t|
  t.libs << "test"
  t.test_files = Dir["test/unit/**/*_test.rb"]
  t.verbose = true
end

require "standard/rake"

task default: :test
