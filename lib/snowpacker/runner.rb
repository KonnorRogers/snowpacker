# frozen_string_literal: true

require "socket"
require "snowpacker/env"
require "thor"

module Snowpacker
  class Runner < Thor::Group
    include Thor::Actions

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
    def build
      snowpacker_command(env: :production, cmd: :build)
    end

    # Serve for development
    def dev
      detect_port!
      snowpacker_command(env: :development, cmd: :dev)
    end

    private

    def snowpacker_command(env: "", cmd: "")
      env = ENV["NODE_ENV"] || env
      command = "NODE_ENV=#{env} yarn run snowpack #{cmd} --config #{@config_file}"
      exec(command)
    end

    def detect_port!
      hostname = Snowpacker.config.hostname
      port = Snowpacker.config.port
      server = TCPServer.new(hostname, port)
      server.close
    rescue Errno::EADDRINUSE
      print_port_in_use(port)
      exit!
    end

    def print_port_in_use(port)
      error_message = "\nUnable to start snowpacker dev server\n\n"
      info_message = <<~INFO
        Another program is currently running on port: #{port}
        Please use a different port.

      INFO
      say error_message, :yellow
      say info_message, :magenta
    end
  end
end
