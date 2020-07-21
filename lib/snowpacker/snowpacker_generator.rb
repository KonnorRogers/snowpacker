# frozen_string_literal: true
require 'rails/generators'

class SnowpackerGenerator < ::Rails::Generators::Base
  TEMPLATES = File.join(File.expand_path(__dir__), 'templates')

  desc 'Generate Snowpacker initializer'
  def create_initializer_file
    initializer 'snowpacker.rb' do
      File.read(File.join(TEMPLATES, 'snowpacker.rb'))
    end
  end

  desc 'Add snowpack to your package.json dependencies'
  def add_snowpack
    `yarn add -D snowpack \
                 @babel/plugin-transform-runtime \
                 babel-plugin-macros \
                 @snowpack/plugin-babel`
  end

  desc 'Create a snowpack.config.json file'
  def create_snowpack_config_file
    create_file Rails.root.join("config", "snowpack.config.json") do
      File.read(File.join(TEMPLATES, 'snowpack.config.json'))
    end
  end
end
