Rails.application.config.parcel do |parcel|
  parcel.entry_points = %w(app/javascript/application.js)
  parcel.destination = 'public/parcels'
end