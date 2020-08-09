# frozen_string_literal: true

require "snowpacker/configuration"
require "snowpacker/env"
require "snowpacker/yarn_packages"
require "snowpacker/proxy"
require "snowpacker/generator"
require "snowpacker/helpers"

module Snowpacker
  YARN_PACKAGES = YarnPackages.all_packages
  # In case youre not using Rails

  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config) if block_given?
  end
end

require "snowpacker/version"
require "snowpacker/runner"
require "snowpacker/engine" if defined?(Rails)
