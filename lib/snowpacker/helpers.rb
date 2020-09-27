require "snowpacker/utils"

module Snowpacker
  module Helpers
    include Utils

    # Returns a <script></script> tag for rails
    # For non-rails, it simply gives the content
    def snowpacker_hmr_tag
      return nil unless dev_server_running?

      hostname = Snowpacker.config.hostname
      port = Snowpacker.config.port

      hmr = %(window.HMR_WEBSOCKET_URL = "ws:#{hostname}:#{port}")

      return tag.script(hmr.html_safe) if rails?

      hmr
    end

    def snowpacker_assets_path(name, **options)
      asset_path("/#{snowpacker_path}/#{assets}", options)
    end

    def snowpacker_entrypoint_tag(name, **options)
      options[:type] ||= "module"

      if dev_server_running?
        javascript_include_tag("/#{snowpacker_path}/entrypoints/#{name}", options)
      end

      ## TODO: Change to reading from manifest for production
      javascript_include_tag("/#{snowpacker_path}/entrypoints/#{name}", options)
    end

    def snowpacker_stylesheet_tag(name, **options)
      options[:media] ||= "screen"
      stylesheet_link_tag("/#{snowpacker_path}/#{name}", options)
    end

    def snowpacker_path
      Snowpacker.config.output_path
    end
  end
end
