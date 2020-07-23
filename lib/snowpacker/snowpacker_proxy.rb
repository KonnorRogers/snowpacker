# frozen_string_literal: true

require 'rack/proxy'

module Snowpacker
  # Proxy server for snowpacker
  class SnowpackerProxy < Rack::Proxy
    def perform_request(env)
      request = Rack::Request.new(env)

      if request.path =~ %r{/snowpacks}
          env["HTTP_HOST"] = "localhost:4035"
          env['HTTP_COOKIE'] = ''
          super(env)
      else
        @app.call(env)
      end
    end
  end
end
