# frozen_string_literal: true

require "rack/proxy"
require "socket"

module Snowpacker
  # Proxy server for snowpacker
  class SnowpackerProxy < Rack::Proxy
    def perform_request(env)
      request = Rack::Request.new(env)

      if request.path =~ %r{^/#{Snowpacker.config.output_path}} && dev_server_running?
        env["HTTP_HOST"] = host_with_port
        env["HTTP_COOKIE"] = ""
        super(env)
      else
        @app.call(env)
      end
    end

    private

    def dev_server_running?
      host = Snowpacker.config.hostname
      port = Snowpacker.config.port
      connect_timeout = 0.01

      Socket.tcp(host, port, connect_timeout: connect_timeout).close
      true
    rescue Errno::ECONNREFUSED
      puts "Snowpacker is not currently running on #{host_with_port}"
      false
    end

    def host_with_port
      hostname = Snowpacker.config.hostname
      port = Snowpacker.config.port
      "#{hostname}:#{port}"
    end
  end
end
