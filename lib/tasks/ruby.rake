require "snowpacker/generator"

namespace :snowpacker do
  desc "initializes snowpacker"
  task :init do
    Snowpacker::Generator.new.init
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
