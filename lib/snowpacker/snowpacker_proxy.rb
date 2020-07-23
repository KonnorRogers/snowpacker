# frozen_string_literal: true

require 'rack/proxy'

module Snowpacker
  # Proxy server for snowpacker
  class SnowpackerProxy < Rack::Proxy
    def rewrite_env(env)
      @app.call(env) unless env["PATH_INFO"].start_with?("/snowpacks/")

      env["HTTP_HOST"] = env["HTTP_X_FORWARDED_HOST"] = "localhost"
      env["HTTP_X_FORWARDED_SERVER"] = "localhost:4035"
      env["HTTP_PORT"] = env["HTTP_X_FORWARDED_PORT"] = "4035"

      # unless https?
      env["HTTPS"] = env["HTTP_X_FORWARDED_SSL"] = "off"
      # end
      env["SCRIPT_NAME"] = ""

      super(env)
    end
  end
end
