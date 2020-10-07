require "rails_helper"
require "erb"

class SnowpackerGeneratorTest < Minitest::Test
  def setup
    remove_rails_snowpacker_dirs
  end

  def teardown
    remove_rails_snowpacker_dirs
  end

  def test_generator_works
    capture_subprocess_io { rails_snowpacker_init }

    out, _err = capture_io {
      Dir.chdir(RAILS_TEST_APP) { system("rails snowpacker:build") }
    }

    assert_match %r{Build Complete!}, out

    context = instance_eval("binding", __FILE__, __LINE__)
    snowpacker_file = ERB.new(File.binread(File.join(TEMPLATE_DIR, "snowpacker.rb.tt")), trim_mode: "-", eoutvar: "@output_buffer").result(context)
    assert_equal File.read(RAILS_SNOWPACKER_INITIALIZER), snowpacker_file

    config_files = %w[snowpack.config.js postcss.config.js babel.config.js]

    config_files.each do |config_file|
      test_file = File.read(File.join(RAILS_CONFIG_DIR, config_file))
      config_file = File.read(File.join(TEMPLATE_DIR, config_file))

      assert_equal test_file, config_file
    end
  end
end
