require "test_helper"

class RakeTasksTest < Minitest::Test
  def test_rake_tasks_in_rails
    output = Dir.chdir(RAILS_TEST_APP) { `bundle exec rails -T` }

    assert_includes output, "snowpacker:dev"
    assert_includes output, "snowpacker:build"

    assert_includes output, "snowpacker:compile"
    assert_includes output, "snowpacker:clobber"

    # generators = Dir.chdir(RAILS_TEST_APP) { `bundle exec rails generate --help` }

    # assert_includes generators, "snowpacker"
  end
end
