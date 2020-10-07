require "test_helper.rb"

class ConfigurationTest < Minitest::Test
  def test_initialize_without_error
    config = Snowpacker::Configuration.new

    assert_instance_of Snowpacker::Configuration, config
  end
end
