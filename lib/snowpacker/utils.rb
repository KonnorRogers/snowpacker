module Snowpacker
  module Utils
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
