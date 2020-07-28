require "minitest"
require "minitest/autorun"
require "rake"
require "snowpacker"

require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

TEST_DIR = File.expand_path(__dir__)
RUBY_TEST_APP = File.join(TEST_DIR, "ruby_test_app")
RAILS_TEST_APP = File.join(TEST_DIR, "rails_test_app")
