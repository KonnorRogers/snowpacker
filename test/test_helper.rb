require "minitest"
require "minitest/autorun"
require "rake"
require "snowpacker"

require "minitest/reporters"
Minitest::Reporters.use!

RUBY_TEST_APP = File.expand_path("test_app")
RAILS_TEST_APP = File.expand_path("rails_test_app")
