# frozen_string_literal: true

require 'rack/proxy'
require 'socket'

module Snowpacker
  # Proxy server for snowpacker
  class SnowpackerProxy < Rack::Proxy
    def initialize(app = nil, opts = {})
      super

      @config = Snowpacker.json_config
    end

    def perform_request(env)
      request = Rack::Request.new(env)

      if request.path =~ %r{/snowpacks} && dev_server_running?
          env["HTTP_HOST"] = "localhost:4035"
          env['HTTP_COOKIE'] = ''
          super(env)
      else
        @app.call(env)
      end
    end

    private

    def dev_server_running?
      host = "localhost"
      port = @config["devOptions"]["port"]
      connect_timeout = 0.01

      socket.tcp(host, port, connect_timeout: connect_timeout).close
      true
    rescue StandardError
      false
    end
  end
end
