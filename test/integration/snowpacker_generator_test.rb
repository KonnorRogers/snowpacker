require 'rails_helper'

class SnowpackerGeneratorTest < Minitest::Test
  SNOWPACKER_INITIALIZER = File.join(RAILS_TEST_APP, "config", "initializers", "snowpacker.rb")
  CONFIG_DIR = File.join(RAILS_TEST_APP, "config", "snowpacker")

  def setup
    Rake.rm_rf(CONFIG_DIR)
    Rake.rm_rf(SNOWPACKER_INITIALIZER)
  end

  def teardown
    Rake.rm_rf(CONFIG_DIR)
    Rake.rm_rf(SNOWPACKER_INITIALIZER)
  end

  def test_generator_works
    Dir.chdir(RAILS_TEST_APP) { `rails generate snowpacker` }

    assert_equal File.read(SNOWPACKER_INITIALIZER), File.read(File.join(TEMPLATE_DIR, "snowpacker.rb"))
  end
end
