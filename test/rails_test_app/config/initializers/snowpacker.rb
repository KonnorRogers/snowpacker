Rails.application.config.middleware.insert_before 0, Snowpacker::Proxy, {ssl_verify_none: true}

Snowpacker.configure do |snowpacker|
  # Where to build snowpack to (out dir)
  snowpacker.build_dir = "public"

  # url to use for assets IE: /snowpacker/xyz.css, gets built to public/frontend
  snowpacker.output_dir = "snowpacker"

  # Where to find the config directory
  snowpacker.config_path = Rails.root.join("config", "snowpacker")
  snowpacker.mount_path = Rails.root.join("app", "snowpacker")
  snowpacker.manifest_file = Rails.root.join(snowpacker.build_dir, snowpacker.output_dir, "manifest.json")

  # Where to find the snowpack config file
  snowpacker.config_file = File.join(snowpacker.config_path, "snowpack.config.js")

  # Where to find the babel config file
  snowpacker.babel_config_file = File.join(snowpacker.config_path, "babel.config.js")

  # Where to find the postcss config file
  snowpacker.postcss_config_file = File.join(snowpacker.config_path, "postcss.config.js")

  # Where to find your snowpack files
  snowpacker.entrypoints_dir = "entrypoints"

  # What port to run snowpacker with
  snowpacker.port = "4035"

  # What hostname to use
  snowpacker.hostname = "localhost"

  # Whether or not to use https
  # https://www.snowpack.dev/#https%2Fhttp2
  snowpacker.https = false
end

ActiveSupport.on_load :action_controller do
  ActionController::Base.helper Snowpacker::Helpers
end

ActiveSupport.on_load :action_view do
  include Snowpacker::Helpers
end
