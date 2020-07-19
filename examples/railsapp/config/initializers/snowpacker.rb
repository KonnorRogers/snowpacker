Rails.application.config.snowpacker do |snowpacker|
  snowpacker.entry_points = %w(app/javascript/snowpacks/application.js)
  snowpacker.destination = 'snowpacks'
end