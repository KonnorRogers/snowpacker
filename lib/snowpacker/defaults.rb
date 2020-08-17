require "snowpacker/configuration"

module Snowpacker
  module Defaults
    def self.config
      Configuration.new do |config|
        config.config_dir = default_config_dir
        config.config_file = File.join(config.config_dir, "snowpack.config.js")
        config.babel_config_file = File.join(config.config_dir, "babel.config.js")
        config.postcss_config_file = File.join(config.config_dir, "postcss.config.js")
        config.mount_dir = File.join("app", "snowpacker")
        config.build_dir = "public"
        config.output_path = "snowpacks"
        config.port = "4035"
        config.hostname = "localhost"
        config.https = "false"
      end
    end

    def self.default_config_dir
      File.join("config", "snowpacker")
    end
  end
end
