# frozen_string_literal: true

require 'socket'

module Snowpacker
  module Rails
    class Runner
      attr_reader :config_file

      def initialize
        @config_file = Snowpacker.configuration.config_file
        @config = Snowpacker.json_config

        detect_port!

        rescue Errno::ENOENT, NoMethodError
          $stdout.puts "Snowpacker configuration not found in #{Snowpacker.config_location}"
          $stdout.puts "Please run bundle exec rails generate snowpacker to install Snowpacker"
          exit!
        end
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
        command = "NODE_ENV=#{env} yarn run snowpack #{cmd} --config #{@config_file}"
        exec(command)
      end

      def detect_port!
        hostname = "127.0.0.1"
        port = @config["devOptions"]["port"]
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
