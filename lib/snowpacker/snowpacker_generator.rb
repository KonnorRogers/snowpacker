# frozen_string_literal: true

require "snowpacker/generator_actions"
require "rails/generators"

class SnowpackerGenerator < Rails::Generators::Base
  desc "Generate Snowpacker initializer"
  def create_initializer_file
  end

  desc "Add snowpack, babel, and postcss to your package.json dependencies"
  def add_snowpacker_yarn_packages
  end

  desc "Create config files IE: babel.config snowpack.config"
  def create_config_files
  end
end
