require '../test_helper.rb'

class TestEnv < Minitest::Test
  def test_sets_env_vars_with_config
    config = Snowpacker.configuration.new

    # By default, only sets output_path, mount_dir, port, and hostname
    Env.set_env_variables(config)
  end
end
