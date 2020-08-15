module Snowpacker
  module Helpers
    def snowpacker_hmr_tag
      if Rails.env.development?
        hostname = Snowpacker.config.hostname
        port = Snowpacker.config.port
        "<script>window.HMR_WEBSOCKET_URL = \"ws:#{hostname}:#{port}\"\</script>"
      end
    end

    def snowpacker_assets_path(name, **options)
      asset_path("/#{snowpacker_path}/#{assets}", options)
    end

    def snowpacker_pack_tag(name, **options)
      options[:type] = "module"
      javascript_include_tag("/#{snowpacker_path}/packs/#{name}", options)
    end

    def snowpacker_stylesheet_link_tag(name, **options)
      options[:media] = "screen" if options[:media].nil?
      stylesheet_link_tag("#{snowpacker_path}/#{name}", options)
    end

    def snowpacker_path
      Snowpacker.config.output_path
    end
  end
end
