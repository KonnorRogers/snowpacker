# frozen_string_literal: true

require "snowpacker/configuration"
require "snowpacker/env"
require "snowpacker/generator"
require "snowpacker/helpers"
require "snowpacker/proxy"
require "snowpacker/utils"
require "snowpacker/yarn_packages"
require "snowpacker/manifest"

module Snowpacker
  YARN_PACKAGES = YarnPackages.all_packages

  class << self
    attr_accessor :config

    def configure
      self.config ||= Configuration.new
      yield(config) if block_given?
    end
  end
end

require "snowpacker/version"
require "snowpacker/runner"
require "snowpacker/engine" if defined?(Rails)
