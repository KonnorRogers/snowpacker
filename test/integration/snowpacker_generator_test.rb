require 'rails_helper'

class SnowpackerGeneratorTest < Minitest::Test
  def setup
  end

  def teardown
  end

  def test_generator_works
    Dir.chdir(RAILS_TEST_APP) { `rails generate snowpacker` }
  end
end
