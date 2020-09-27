# frozen_string_literal: true

require "socket"
require "snowpacker/env"
require "snowpacker/utils"
require "thor"

module Snowpacker
  class Runner < Thor::Group
    include ::Thor::Actions
    include Utils

    attr_reader :config_file

    def initialize
      Env.set_env_variables
      @config_file = Snowpacker.config.config_file
    rescue Errno::ENOENT, NoMethodError
      $stdout.puts "Snowpacker configuration not found in #{Snowpacker.config_location}"
      $stdout.puts "Please run bundle exec rails generate snowpacker to install Snowpacker"
      exit!
    end

    # Build for production
    def self.build
      new
      snowpacker_command(env: :production, cmd: :build)
    end

    # Serve for development
    def self.dev
      detect_port!
      new
      snowpacker_command(env: :development, cmd: :dev)
    end

    private

    def self.snowpacker_command(env: "", cmd: "")
      env = ENV["NODE_ENV"] || env
      command = "NODE_ENV=#{env} yarn run snowpack #{cmd} --config #{@config_file}"
      Rake.sh(command)
    end
  end
end
