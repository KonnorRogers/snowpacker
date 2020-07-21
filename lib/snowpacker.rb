# frozen_string_literal: true

require 'snowpacker/configuration'

module Snowpacker
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end

require 'snowpacker/snowpacker_generator.rb'
require 'snowpacker/runner'
require "snowpacker/engine" if defined?(Rails)

