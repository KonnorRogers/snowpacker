require "rails_helper"
require "erb"

class SnowpackerGeneratorTest < Minitest::Test
  def setup
    remove_rails_snowpacker_dirs
  end

  def teardown
    remove_rails_snowpacker_dirs
  end

  def cleanup_yarn_packages
    yarn_packages = Snowpacker::YARN_PACKAGES.map { |pkg|
      if pkg == "core-js@3"
        pkg = "core-js"
      end

      pkg
    }
    Dir.chdir(RAILS_TEST_APP) { `yarn remove #{yarn_packages.join(" ")}` }
  end

  def test_generator_works
    capture_subprocess_io { rails_snowpacker_init }

    out, _err = capture_subprocess_io {
      Dir.chdir(RAILS_TEST_APP) { system("rails snowpacker:build") }
    }

    assert_match %r{Build Complete!}, out

    context = instance_eval("binding", __FILE__, __LINE__)
    snowpacker_file = ERB.new(File.binread(File.join(TEMPLATE_DIR, "snowpacker.rb.tt")), trim_mode: "-", eoutvar: "@output_buffer").result(context)
    assert_equal File.read(RAILS_SNOWPACKER_INITIALIZER), snowpacker_file

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
      test_file = File.read(File.join(RAILS_CONFIG_DIR, config_file))
      config_file = File.read(File.join(TEMPLATE_DIR, config_file))

      assert_equal test_file, config_file
    end

    capture_subprocess_io { cleanup_yarn_packages }
  end
end
