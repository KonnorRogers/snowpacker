require "cgi"

module Snowpacker
  module Helpers
    def rails?
      return true if defined?(Rails)
    end

    # Returns a <script></script> tag for rails
    # For non-rails, it simply gives the content
    def snowpacker_hmr_tag
      hostname = Snowpacker.config.hostname
      port = Snowpacker.config.port

      hmr = %(window.HMR_WEBSOCKET_URL = "ws:#{hostname}:#{port}")

      return tag.script(hmr.html_safe) if rails?

      hmr
    end

    def snowpacker_assets_path(name, **options)
      asset_path("/#{snowpacker_path}/#{assets}", options)
    end

    def snowpacker_pack_tag(name, **options)
      options[:type] ||= "module"
      javascript_include_tag("/#{snowpacker_path}/packs/#{name}", options)
    end

    def snowpacker_stylesheet_link_tag(name, **options)
      options[:media] ||= "screen"
      stylesheet_link_tag("/#{snowpacker_path}/#{name}", options)
    end

    def snowpacker_path
      Snowpacker.config.output_path
    end
  end
end
