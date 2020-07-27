# frozen_string_literal: true

require "snowpacker/configuration"

module Snowpacker
  class << self
    attr_accessor :config
  end

  def self.config_location
    Rails.root.join("config", "snowpack.config.json")
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config)
  end
end

require "snowpacker/snowpacker_proxy"
require "snowpacker/snowpacker_generator"
require "snowpacker/runner"
require "snowpacker/engine" if defined?(Rails)
