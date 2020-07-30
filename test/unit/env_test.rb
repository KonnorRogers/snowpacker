require "test_helper.rb"

class TestEnv < Minitest::Test
  def test_sets_env_vars_appropriately
    Snowpacker.configure
    Snowpacker.config.hostname = "hostname"

    # By default, only sets output_path, mount_dir, port, and hostname
    Snowpacker::Env.set_env_variables(Snowpacker.config)

    assert_equal Snowpacker.config.hostname, ENV["SNOWPACKER_HOSTNAME"]

    Snowpacker.config.hostname = nil
    Snowpacker::Env.set_env_variables(Snowpacker.config)

    assert Snowpacker.config.hostname.nil?
  end
end
