
require 'rails/railtie'

module Snowpacker
  class Engine < ::Rails::Engine
    isolate_namespace Snowpacker

    config.snowpacker = Snowpacker::Configuration.new
  end
end
