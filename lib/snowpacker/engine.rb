require 'rails/railtie'

module Snowpacker
  class Engine < ::Rails::Engine
    isolate_namespace Snowpacker

    config.snowpacker = ActiveSupport::OrderedOptions.new
  end
end
