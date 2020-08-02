# frozen_string_literal: true

require "rails/generators"

class SnowpackerGenerator < ::Rails::Generators::Base
  TEMPLATES = File.join(File.expand_path(__dir__), "templates")

  desc "Generate Snowpacker initializer"
  def create_initializer_file
    initializer "snowpacker.rb" do
      File.read(File.join(TEMPLATES, "snowpacker.rb"))
    end
  end

  desc "Add snowpack, babel, and postcss to your package.json dependencies"
  def add_snowpack
    %x(yarn add -D #{::Snowpacker::YARN_PACKAGES.join(" ")})
  end

  desc "Create config files IE: babel.config snowpack.config"
  def create_config_files
    config_files = %w[
      snowpack.config.js
      postcss.config.js
      babel.config.js
    ]

    config_files.each do |filename|
      template File.join(TEMPLATES, filename), Rails.root.join("config", "snowpacker", filename)
    end
  end
end
