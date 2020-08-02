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

    def in_root
    end

    def create_initializer_file
      target = "snowpacker.rb"
      source = File.join(TEMPLATES, "#{target}.tt")

      destination = File.join("config", "initializers", target)

      if defined?(Rails)
        destination = Rails.root.join("config", "initializers", target)

        template source, destination
      end

      # Creates a config/initializers/snowpacker.rb file
      template File.read(source), destination
    end

    def create_config_files
      destination = File.join("config", "snowpacker")

      if defined?(Rails)
        destination = Rails.root.join("config", "snowpacker")
      end

      CONFIG_FILES.each do |filename|
        template File.join(TEMPLATES, filename), File.join(destination, filename)
      end
    end

    def add_yarn_packages
      %x(yarn add -D #{::Snowpacker::YARN_PACKAGES.join(" ")})
    end

    def init
      create_initializer_file
      create_config_files
      add_yarn_packages
    end
  end
end
