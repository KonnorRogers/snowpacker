# frozen_string_literal: true
require 'rails/generators'

class ParcelGenerator < ::Rails::Generators::Base
  desc 'Generate parcel-rails initializer'

  def create_initializer_file
    initializer 'parcel.rb' do
      %{Rails.application.config.parcel do |parcel|
  parcel.entry_points = %w(app/javascript/application.js)
  parcel.destination = 'public/parcels'
end}
    end
  end

  def add_parcel_bundler
    `yarn add parcel-bundler`
  end
end
