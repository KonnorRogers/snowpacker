require 'json'

Snowpacker.configure do |snowpacker|
  # Where to find the config file
  snowpacker.config_file = Rails.root.join('config', 'snowpack.config.json')

  # A parsed version of the config file
  snowpacker.json_config = JSON.parse(File.read(snowpacker.config_file))
end

