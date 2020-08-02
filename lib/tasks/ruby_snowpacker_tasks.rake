require "snowpacker/generator_actions"

namespace :snowpacker do
  desc "initializes snowpacker"
  task init: :environment do
    GeneratorActions.create_initializer_file
    GeneratorActions.create_config_files
    GeneratorActions.add_yarn_packages
  end

  desc "Compiles assets using snowpack bundler"
  task build: :environment do
    Snowpacker::Runner.new.build
  end

  desc "Compiles assets using snowpack bundler"
  task compile: :build

  desc "Run a snowpack dev server"
  task dev: :environment do
    Snowpacker::Runner.new.dev
  end

  desc "Removes compiled assets"
  task clobber: :environment do
    command = "rm -rf #{Snowpacker.config.destination}"
    logger = Logger.new(STDOUT)
    logger.info(command)
    exec(command)
  end
end
