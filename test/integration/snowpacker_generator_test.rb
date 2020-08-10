require "rails_helper"
require "erb"

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

  Minitest.after_run do
    yarn_packages = Snowpacker::YARN_PACKAGES.map { |pkg|
      if pkg == "core-js@3"
        pkg = "core-js"
      end

      pkg
    }

    Dir.chdir(RAILS_TEST_APP) { `yarn remove #{yarn_packages.join(" ")}` }
  end

  def test_generator_works
    Dir.chdir(RAILS_TEST_APP) { `rails snowpacker:init` }

    context = instance_eval("binding")
    snowpacker_file = ERB.new(File.binread(File.join(TEMPLATE_DIR, "snowpacker.rb.tt")), nil, "-", "@output_buffer").result(context)
    assert_equal File.read(SNOWPACKER_INITIALIZER), snowpacker_file

    package_json = File.read(File.join(RAILS_TEST_APP, "package.json"))
    Snowpacker::YARN_PACKAGES.each do |pkg|
      # work around core-js@3 which turns to "core-js": "3"
      if pkg == "core-js@3"
        pkg = "core-js"
      end

      assert_includes package_json, pkg
    end

    config_files = %w[snowpack.config.js postcss.config.js babel.config.js]

    config_files.each do |config_file|
      test_file = File.read(File.join(CONFIG_DIR, config_file))
      config_file = File.read(File.join(TEMPLATE_DIR, config_file))

      assert_equal test_file, config_file
    end
  end
end
