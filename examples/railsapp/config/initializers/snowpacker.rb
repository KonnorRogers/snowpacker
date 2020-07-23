Snowpacker.configure do |snowpacker|
  # Where to find the config file
  snowpacker.config_file = Rails.root.join('config', 'snowpack.config.json')
  snowpacker.json_config = JSON.parse(File.read(snowpacker.config_file))

  # Where your javascript is located
  # snowpacker.source_path = Rails.root.join('app', 'javascript')
  # snowpacker.entry_points = [File.join(snowpacker.source_path, 'snowpacks', 'application.js')]

  # # Where to output your files to
  # snowpacker.out = Rails.root.join('snowpacks')
  # snowpacker.javascript = File.join(snowpacker.out, 'javascript')
  # snowpacker.stylesheets = File.join(snowpacker.out, 'stylesheets')
  # snowpacker.assets = File.join(snowpacker.out, 'assets')
end

