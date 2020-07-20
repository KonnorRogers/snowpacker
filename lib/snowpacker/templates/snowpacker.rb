Rails.application.config.snowpacker do |_snowpacker|
  # Where to find the config file
  config.snowpacker.config_file = Rails.root.join('config', 'snowpack.config.json')

  # Where your javascript is located
  config.snowpacker.source_path = Rails.root.join('app', 'javascript')
  config.snowpacker.entry_points = [File.join(config.snowpacker.source_path, 'snowpacks', 'application.js')]

  # Where to output your files to
  config.snowpacker.out = Rails.root.join('snowpacks')
  config.snowpacker.javascript = File.join(config.snowpacker.out, 'javascript')
  config.snowpacker.stylesheets = File.join(config.snowpacker.out, 'stylesheets')
  config.snowpacker.assets = File.join(config.snowpacker.out, 'assets')
end
