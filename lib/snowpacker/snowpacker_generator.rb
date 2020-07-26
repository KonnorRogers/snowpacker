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
                 @babel/plugin-transform-regenerator
    `
  end

  desc 'Create config files IE: babel.config snowpack.config'
  def create_config_files
    config_files = %w[
      snowpack.config.js
      postcss.config.js
      babel.config.js
      .browserslistrc
    ]

    create_file Rails.root.join('config', 'snowpacker', filename) do
      File.read(File.join(TEMPLATES, filename))
    end
  end
end
