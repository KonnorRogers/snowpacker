# frozen_string_literal: true

require "socket"
require "snowpacker/env"
require "snowpacker/utils"
require "thor"

module Snowpacker
  class Runner < Thor::Group
    include ::Thor::Actions

    attr_reader :config_file

    def initialize
      Env.set_env_variables
    rescue Errno::ENOENT, NoMethodError
      $stdout.puts "Snowpacker configuration not found in #{Snowpacker.config_location}"
      $stdout.puts "Please run bundle exec rails generate snowpacker to install Snowpacker"
      exit!
    end

    class << self
      # Build for production
      def build
        new
        snowpacker_command(env: :production, cmd: :build)
      end

      # Serve for development
      def dev
        Utils.detect_port!
        new
        snowpacker_command(env: :development, cmd: :dev)
      end

      private

      def snowpacker_command(env: "", cmd: "")
        env = ENV["NODE_ENV"] || env
        config_file = File.expand_path(Snowpacker.config.config_file)
        command = "NODE_ENV=#{env} yarn run snowpack #{cmd} --config #{config_file}"
        Rake.sh(command)
      end
    end
  end
end
