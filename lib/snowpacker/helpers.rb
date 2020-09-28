require "snowpacker/utils"

module Snowpacker
  module Helpers
    # Injects an HMR tag during development via a websocket.
    def snowpacker_hmr_tag
      return unless Rails.env == "development"

      hostname = Snowpacker.config.hostname
      port = Snowpacker.config.port

      hmr = %(window.HMR_WEBSOCKET_URL = "ws:#{hostname}:#{port}")

      return tag.script(hmr.html_safe) if Utils.rails?

      hmr
    end

    def snowpacker_asset_path(name, **options)
      asset_path(File.join(snowpacker_dir, name), options)
    end

    def javascript_snow_tag(name, **options)
      options[:type] ||= "module"

      if Utils.dev_server_running?
        javascript_include_tag("/#{snowpacker_dir}/#{entrypoints_dir}/#{name}", options)
      end

      ## TODO: Change to reading from manifest for production
      javascript_include_tag("/#{snowpacker_dir}/#{entrypoints_dir}/#{name}", options)
    end

    # Returns nothing when not in production. CSS only gets extracted
    # during the final build.
    def stylesheet_snow_tag(name, **options)
      return unless Rails.env == "development"

      options[:media] ||= "screen"
      stylesheet_link_tag("/#{snowpacker_dir}/#{name}", options)
    end

    def snowpacker_dir
      Snowpacker.config.output_dir
    end

    def entrypoints_dir
      Snowpacker.config.entrypoints_dir
    end
  end
end
