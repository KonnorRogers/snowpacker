class SnowpackerBuildTest < Minitest::Test
  def setup
    remove_rails_snowpacker_dirs
  end

  def teardown
    remove_rails_snowpacker_dirs
  end

  def it_builds_properly
    rails_snowpacker_init
    out, _err = capture_subprocess_io {
      Dir.chdir(RAILS_TEST_APP) { system("rails snowpacker:build") }
    }

    assert_match %r{Build Complete!}, out
  end
end
