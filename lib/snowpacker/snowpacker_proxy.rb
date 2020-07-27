# frozen_string_literal: true

require "rack/proxy"
require "socket"

module Snowpacker
  # Proxy server for snowpacker
  class SnowpackerProxy < Rack::Proxy
    def perform_request(env)
      # request = Rack::Request.new(env)

      if env["PATH_INFO"].start_with?(%r{/#{Snowpacker.config.output_path}}) && dev_server_running?
        env["HTTP_HOST"] = env["HTTP_X_FORWARDED_HOST"] = "localhost"
        env["HTTP_X_FORWARDED_SERVER"] = host_with_port
        env["HTTP_PORT"] = env["HTTP_X_FORWARDED_PORT"] = "4035"
        env["HTTP_X_FORWARDED_PROTO"] = env["HTTP_X_FORWARDED_SCHEME"] = "http"

        # unless dev_server.https?
          env["HTTPS"] = env["HTTP_X_FORWARDED_SSL"] = "off"
        # end

        env["SCRIPT_NAME"] = ""

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
