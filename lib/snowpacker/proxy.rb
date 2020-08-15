# frozen_string_literal: true

require "rack/proxy"
require "socket"

module Snowpacker
  # Proxy server for snowpacker
  class Proxy < Rack::Proxy
    def initialize(app = nil, opts = {})
      opts[:streaming] = false if Rails.env.test? && !opts.key?(:streaming)
      super
    end

    def perform_request(env)
      output_path = %r{/#{Snowpacker.config.output_path}}
      if env["PATH_INFO"].start_with?(output_path) && dev_server_running?
        env["HTTP_HOST"] = env["HTTP_X_FORWARDED_HOST"] = Snowpacker.config.hostname
        env["HTTP_X_FORWARDED_SERVER"] = host_with_port
        env["HTTP_PORT"] = env["HTTP_X_FORWARDED_PORT"] = Snowpacker.config.port
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
      false
    end

    def host_with_port
      hostname = Snowpacker.config.hostname
      port = Snowpacker.config.port
      "#{hostname}:#{port}"
    end
  end
end
