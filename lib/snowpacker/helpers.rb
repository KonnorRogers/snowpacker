module Snowpacker
  class Helpers
    def snowpacker_assets_path(name, **options)
      asset_path("/#{snowpacker_path}/#{assets}")
    end

    def snowpacker_javascript_tag(name, **options)
      options[:type] = "module" if options[:type].nil?
      javascript_include_tag("/#{snowpacker_path}/#{name}", **options)
    end

    def snowpacker_stylesheet_link_tag(name, **options)
      options[:media] = "screen" if options[:media].nil?
      stylesheet_link_tag("#{snowpacker_path}/#{name}", **options)
    end

    def snowpacker_path
      Snowpacker.config.output_path
    end
  end
end
