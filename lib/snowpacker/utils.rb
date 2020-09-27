module Snowpacker
  module Utils
    class << self
      def detect_port!
        hostname = Snowpacker.config.hostname
        port = Snowpacker.config.port
        server = TCPServer.new(hostname, port)
        server.close
      rescue Errno::EADDRINUSE
        print_port_in_use(port)
        exit!
      end

      def rails?
        return true if defined?(Rails)
      end

      def https?
        return true if ENV["SNOWPACKER_HTTPS"] == "true"

        false
      end

      def dev_server_running?
        host = Snowpacker.config.hostname
        port = Snowpacker.config.port
        connect_timeout = 0.01

        Socket.tcp(host, port, connect_timeout: connect_timeout).close
        true
      rescue Errno::ECONNREFUSED
        false
      end

      def host_with_port
        hostname = Snowpacker.config.hostname
        port = Snowpacker.config.port
        "#{hostname}:#{port}"
      end

    private

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
end
