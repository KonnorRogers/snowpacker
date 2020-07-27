# frozen_string_literal: true

require "snowpacker/configuration"
require "snowpacker/snowpacker_proxy"

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

require "snowpacker/version"
require "snowpacker/snowpacker_generator" if defined?(Rails)
require "snowpacker/runner" if defined?(Rails)
require "snowpacker/engine" if defined?(Rails)
