require "fileutils"
require "minitest"
require "minitest/autorun"
require "rake"
require "snowpacker"

require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true, slow_count: 5)]

TEST_DIR = File.expand_path(__dir__)
RUBY_TEST_APP = File.join(TEST_DIR, "ruby_test_app")
RAILS_TEST_APP = File.join(TEST_DIR, "rails_test_app")

RAILS_SNOWPACKER_INITIALIZER = File.join(RAILS_TEST_APP, "config", "initializers", "snowpacker.rb")
RAILS_CONFIG_DIR = File.join(RAILS_TEST_APP, "config", "snowpacker")
RAILS_BUILD_DIR = File.join(RAILS_TEST_APP, "public", "snowpacks")

ROOT_DIR = File.expand_path("..", __dir__)
TEMPLATE_DIR = File.join(ROOT_DIR, "lib", "snowpacker", "templates")

def remove_rails_snowpacker_dirs
  FileUtils.rm_rf(RAILS_CONFIG_DIR)
  FileUtils.rm_rf(RAILS_BUILD_DIR)
  FileUtils.rm_rf(RAILS_SNOWPACKER_INITIALIZER)
end

def rails_snowpacker_init
  Dir.chdir(RAILS_TEST_APP) { `rails snowpacker:init` }
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

Minitest.after_run { remove_rails_snowpacker_dirs }
