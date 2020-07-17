Rails.application.config.snowpacker do |snowpacker|
  snowpacker.entry_points = %w(app/javascript/application.js)
  snowpacker.destination = 'public/snowpacks'
end
