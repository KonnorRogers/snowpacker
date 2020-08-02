module Snowpacker
  module GeneratorActions
    TEMPLATES = File.join(File.expand_path(__dir__), "templates")
    CONFIG_FILES = %w[
      snowpack.config.js
      postcss.config.js
      babel.config.js
    ]

    def self.create_initializer_file
      target = "snowpacker.rb"
      source = File.join(TEMPLATES, target)

      destination = File.join("config", "initializers", target)

      if defined?(Rails)
        destination = Rails.root.join("config", "initializers", target)

        template File.read(source), destination
      end

      # Creates a config/initializers/snowpacker.rb file
      template File.read(source), destination
    end

    def self.create_config_files
      destination = File.join("config", "snowpacker")

      if defined?(Rails)
        destination = Rails.root.join("config", "snowpacker")
      end

      CONFIG_FILES.each do |filename|
        template File.join(TEMPLATES, filename), File.join(destination, filename)
      end
    end

    def self.add_yarn_packages
      %x(yarn add -D #{::Snowpacker::YARN_PACKAGES.join(" ")})
    end
  end
end
