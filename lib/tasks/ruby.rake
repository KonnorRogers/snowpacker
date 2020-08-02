require "snowpacker/generator_actions"

namespace :snowpacker do
  desc "initializes snowpacker"
  task :init do
    GeneratorActions.create_initializer_file
    GeneratorActions.create_config_files
    GeneratorActions.add_yarn_packages
  end

  desc "Compiles assets using snowpack bundler"
  task :build do
    Snowpacker::Runner.new.build
  end

  desc "Compiles assets using snowpack bundler"
  task compile: :build

  desc "Run a snowpack dev server"
  task :dev do
    Snowpacker::Runner.new.dev
  end
end
