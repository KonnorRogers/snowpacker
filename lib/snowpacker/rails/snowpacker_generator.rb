# frozen_string_literal: true
require 'rails/generators'

class SnowpackerGenerator < ::Rails::Generators::Base
  desc 'Generate Snowpacker initializer'

  def create_initializer_file
    initializer 'snowpacker.rb' do <<-RUBY
      Rails.application.config.snowpacker do |snowpacker|
        # Where to find the config file
        config.snowpacker.config_file = File.join('app', 'config', 'snowpack.config.json')

        # Where your javascript is located
        config.snowpacker.source_path = File.join('app', 'javascript')
        config.snowpacker.entry_points = [File.join(config.snowpacker.source_path, 'snowpacks', 'application.js')]

        # Where to output your files to
        config.snowpacker.out = 'snowpacks'
        config.snowpacker.javascript = File.join(config.snowpacker.out, 'javascript')
        config.snowpacker.stylesheets = File.join(config.snowpacker.out, 'stylesheets')
        config.snowpacker.assets = File.join(config.snowpacker.out, 'assets')
      end
    RUBY
    end
  end

  desc 'Add snowpack to your package.json dependencies'
  def add_snowpack
    `yarn add -D snowpack \
                 @snowpack/plugin-babel`
  end

  desc 'Create a snowpack.config.json file'
  def create_snowpack_config_file
    create_file File.join("app", "config", "snowpack.config.json") do <<-JSON
      {
        "installOptions": {
          "NODE_ENV": true
        },
        "scripts": {
          "mount:javascript": "mount app/javascript/snowpacks --to /snowpacks/javascript",
          "mount:stylesheets": "mount app/javascript/stylesheets --to /snowpacks/stylesheets",
          "mount:assets": "mount app/javascript/assets --to /snowpacks/assets",
          "mount:snowpacks": "mount snowpacks --to /"
        },
        "devOptions": {
          "port": 4035,
          "open": "none",
          "out": "snowpacks"
        },
        "proxy": {
          "0.0.0.0:4035": "0.0.0.0:4035"
        },
        "buildOptions": {
          "clean": true,
          "baseUrl": "/"
        },
        "plugins": [
          "@snowpack/plugin-babel"
        ]
      }
    JSON
    end
  end
end
