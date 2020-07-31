namespace :snowpacker do
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
    command = "rm -rf #{::Rails.application.config.snowpacker.destination}"
    logger = Logger.new(STDOUT)
    logger.info(command)
    exec(command)
  end
end

Rake::Task["assets:precompile"].enhance do
  Rake::Task["snowpacker:build"].invoke
end

Rake::Task["assets:clobber"].enhance do
  Rake::Task["snowpacker:clobber"].invoke
end
