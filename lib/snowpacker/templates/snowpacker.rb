Snowpacker.configure do |snowpacker|
  # Where to find the config file
  snowpacker.config_file = Rails.root.join('config', 'snowpack.config.json')

  snowpacker.port = "4035" # Port to run on
  snowpacker.hostname = "localhost" # hostname to use
end

