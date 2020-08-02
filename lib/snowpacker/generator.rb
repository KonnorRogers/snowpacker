require 'thor'

module Snowpacker
  class Generator < Thor::Group
    include Thor::Actions

    TEMPLATES = File.join(File.expand_path(__dir__), "templates")
    CONFIG_FILES = %w[
      snowpack.config.js
      postcss.config.js
      babel.config.js
    ]

    def self.source_root
      TEMPLATES
    end

    def create_initializer_file
      target = "snowpacker.rb"
      source = "#{target}.tt"

      destination = File.join("config", "initializers", target)

      if defined?(Rails)
        destination = Rails.root.join("config", "initializers", target)

        template source, destination
      end

      # Creates a config/initializers/snowpacker.rb file
      puts "Creating initializer file at #{destination}..."
      template source, destination
    end

    def create_config_files
      destination = File.join("config", "snowpacker")

      if defined?(Rails)
        destination = Rails.root.join("config", "snowpacker")
      end

      puts "Creating config files @ #{destination}"
      CONFIG_FILES.each do |filename|
        template filename, File.join(destination, filename)
      end
    end

    def add_yarn_packages
      puts "Adding yarn packages..."
      %x(yarn add -D #{::Snowpacker::YARN_PACKAGES.join(" ")})
    end

    def init
      create_initializer_file
      create_config_files
      add_yarn_packages
    end
  end
end
