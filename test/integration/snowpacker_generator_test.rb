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

    output = Dir.chdir(RAILS_TEST_APP) { `rails snowpacker:build` }

    assert_match %r{Build Complete!}, output

    context = instance_eval("binding", __FILE__, __LINE__)

    file = File.binread(File.join(TEMPLATE_DIR, "snowpacker.rb.tt"))
    trim_mode = "-"
    eoutvar = "@output_buffer"

    snowpacker_file = nil

    # Account for ERB argument deprecation from 2.5 -> 2.6
    # https://bugs.ruby-lang.org/issues/14256 

    if Gem::Version($RUBY_VERSION) < Gem::Version("2.6.0")
      snowpacker_file = ERB.new(file, 1, trim_mode, eoutvar)
    else
      snowpacker_file = ERB.new(file, trim_mode: trim_mode, eoutvar: eoutvar)
    end

    snowpacker_file = snowpacker_file.result(context)
    assert_equal File.read(RAILS_SNOWPACKER_INITIALIZER), snowpacker_file

    config_files = %w[snowpack.config.js postcss.config.js babel.config.js]

    config_files.each do |config_file|
      test_file = File.read(File.join(RAILS_CONFIG_DIR, config_file))
      config_file = File.read(File.join(TEMPLATE_DIR, config_file))

      assert_equal test_file, config_file
    end
  end
end
