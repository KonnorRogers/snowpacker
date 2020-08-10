require "test_helper"

class RakeTasksTest < Minitest::Test
  def test_rake_tasks_in_rails
    output = Dir.chdir(RAILS_TEST_APP) { `bundle exec rails -T` }

    assert_includes output, "snowpacker:init"
    assert_includes output, "snowpacker:dev"
    assert_includes output, "snowpacker:build"
    assert_includes output, "snowpacker:compile"
    assert_includes output, "snowpacker:clobber"
  end
end
