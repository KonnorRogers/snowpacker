require "minitest"
require "minitest/autorun"
require "rake"
require "snowpacker"

require "minitest/reporters"
Minitest::Reporters.use!

TEST_APP = File.expand_path("test_app")
