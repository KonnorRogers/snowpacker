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
        config.snowpacker.entry_points = %w[app/javascript/application.js]
        config.snowpacker.destination = 'public/snowpacks'
      end
    end
  end
end
