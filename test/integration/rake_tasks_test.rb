require "test_helper"

class RakeTasksTest < Minitest::Test
  def test_rake_tasks
    output = Dir.chdir() { `rake -T` }
  end
end
