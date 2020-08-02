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

      # If the project uses Rails
      if defined?(Rails)
        initializer(target) do
          File.read(source)
        end
      end

      # Creates a config/initializers/snowpacker.rb file
      create_file File.join("config", "initializers", target), File.read(source)
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
