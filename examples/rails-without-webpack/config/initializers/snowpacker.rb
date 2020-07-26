Snowpacker.configure do |snowpacker|
  # Where to find the config file
  snowpacker.config_dir = Rails.root.join('config', 'snowpacker')
  snowpacker.config_file = File.join(snowpacker.config_dir, 'snowpack.config.js')

  snowpacker.babel_config_file = File.join(snowpacker.config_dir, 'babel.config.js')
  snowpacker.postcss_config_file = File.join(snowpacker.config_dir, 'postcss.config.js')

  snowpacker.mount_dir = File.join('app', 'javascript')
  snowpacker.output_path = "snowpacks" # => /public/snowpacks
  snowpacker.port = "4035"

  # Currently, snowpack does not support the hostname option as of version 2.6.4
  # Support should be coming in 2.6.5, so until then, this is just a placeholder.
  snowpacker.hostname = "localhost"
end


