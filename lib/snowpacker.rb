# frozen_string_literal: true

require 'snowpacker/rails/version'
require 'snowpacker/rails/runner'
require 'snowpacker/rails/snowpacker_generator' if defined?(Rails)

module Snowpacker
  # Snowpack integration with Rails
  module Rails
    if defined?(::Rails)
      module Rails
        class Application
          attr_accessor :snowpacker
        end
      end

      class Railtie < ::Rails::Railtie
        railtie_name :snowpacker

        rake_tasks do
          load 'snowpacker/rails/tasks.rake'
        end

        config.snowpacker = ActiveSupport::OrderedOptions.new
          # config.snowpacker.config_file = File.join('app', 'config', 'snowpack.config.json')
          # config.snowpacker.source_path = File.join('app', 'javascript')
          # config.snowpacker.entry_points = [File.join(config.snowpacker.source_path, 'snowpacks', 'application.js')]
          # config.snowpacker.out = 'snowpacks'
          # config.snowpacker.javascript = File.join(config.snowpacker.out, 'javascript')
          # config.snowpacker.stylesheets = File.join(config.snowpacker.out, 'stylesheets')
          # config.snowpacker.assets = File.join(config.snowpacker.out, 'assets')
      end
    end
  end
end
