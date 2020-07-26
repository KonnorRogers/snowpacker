# frozen_string_literal: true
require 'rails/generators'

class SnowpackerGenerator < ::Rails::Generators::Base
  TEMPLATES = File.join(File.expand_path(__dir__), 'templates')

  desc 'Generate Snowpacker initializer'
  def create_initializer_files
    initializer 'snowpacker.rb' do
      File.read(File.join(TEMPLATES, 'snowpacker.rb'))
    end
  end

  desc 'Add snowpack, babel, and postcss to your package.json dependencies'
  def add_snowpack
    `yarn add -D snowpack \
                 core-js@3 \
                 postcss \
                 postcss-cli \
                 @babel/core \
                 @babel/cli \
                 @babel/preset-env \
                 @babel/plugin-transform-runtime \
                 babel-plugin-macros \
                 @snowpack/plugin-babel \
                 @babel/preset-env \
                 babel-plugin-macros \
                 @babel/plugin-syntax-dynamic-import \
                 babel-plugin-dynamic-import-node \
                 @babel/plugin-transform-destructuring \
                 @babel/plugin-proposal-class-properties \
                 @babel/plugin-proposal-object-rest-spread \
                 @babel/plugin-transform-runtime \
                 @babel/plugin-transform-regenerator \
    `
  end

  desc 'Create a snowpack.config.json file'
  def create_snowpack_config_file
    create_file Rails.root.join("config", "snowpack.config.json") do
      File.read(File.join(TEMPLATES, 'snowpack.config.json'))
    end
  end
end
