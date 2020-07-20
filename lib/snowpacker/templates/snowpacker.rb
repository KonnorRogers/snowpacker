Rails.application.config.snowpacker do |snowpacker|
  # Where to find the config file
  snowpacker.config_file = Rails.root.join('config', 'snowpack.config.json')

  # Where your javascript is located
  snowpacker.source_path = Rails.root.join('app', 'javascript')
  snowpacker.entry_points = [File.join(config.snowpacker.source_path, 'snowpacks', 'application.js')]

  # Where to output your files to
  snowpacker.out = Rails.root.join('snowpacks')
  snowpacker.javascript = File.join(config.snowpacker.out, 'javascript')
  snowpacker.stylesheets = File.join(config.snowpacker.out, 'stylesheets')
  snowpacker.assets = File.join(config.snowpacker.out, 'assets')
end
