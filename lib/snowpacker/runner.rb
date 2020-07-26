# frozen_string_literal: true

require 'socket'
require 'snowpacker/env'

module Snowpacker
  module Rails
    class Runner
      attr_reader :config_file

      def initialize
        @config_file = Snowpacker.config.config_file
        Env.set_env_variables

        detect_port!

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
        snowpacker_command(env: :development, cmd: :dev)
      end

      private

      def snowpacker_command(env: '', cmd: '')
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
        $stdout.puts "Another program is running on port #{port}.\n
                      Set a new port in #{Snowpacker.config_path} for devOptions: { port: \"#{port}\" }"
        exit!
      end
    end
  end
end
