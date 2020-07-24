Snowpacker.configure do |snowpacker|
  # Where to find the config file
  snowpacker.config_file = Rails.root.join('config', 'snowpack.config.js')

  # Snowpacker will set these values at runtime via `config/snowpack.config.js`
  snowpacker.output_path = "snowpacks" # => /public/snowpacks
  snowpacker.port = "4035"

  # Currently, snowpack does not support the hostname option as of version 2.6.4
  # Support should be coming in 2.6.5, so until then, this is just a placeholder.
  snowpacker.hostname = "localhost"
end

