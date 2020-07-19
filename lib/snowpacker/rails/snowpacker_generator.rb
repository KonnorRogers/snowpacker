# frozen_string_literal: true
require 'rails/generators'

class SnowpackerGenerator < ::Rails::Generators::Base
  desc 'Generate Snowpacker initializer'

  def create_initializer_file
    initializer 'snowpacker.rb' do
      %{Rails.application.config.snowpacker do |snowpacker|
  snowpacker.entry_points = %w(app/javascript/snowpacks/application.js)
  snowpacker.destination = 'snowpacks'
end}
    end
  end

  def add_snowpack
    `yarn add -D snowpack \
                 parcel-bundler \
                 @snowpack/plugin-babel \
                 @snowpack/plugin-parcel`
  end
end
