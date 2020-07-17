# frozen_string_literal: true

namespace :snowpacker do
  desc 'Compiles assets using snowpack bundler'
  task compile: :environment do
    Snowpacker::Rails::Runner.from_config.compile
  end

  desc 'Compiles assets using snowpack bundler'
  task serve: :environment do
    Snowpacker::Rails::Runner.from_config.serve
  end

  desc 'Removes compiled assets'
  task clobber: :environment do
    command = "rm -rf #{::Rails.application.config.snowpacker.destination}"
    logger = Logger.new(STDOUT)
    logger.info(command)
    exec(command)
  end
end

Rake::Task['assets:precompile'].enhance do
  Rake::Task['snowpacker:compile'].invoke
end

Rake::Task['assets:clobber'].enhance do
  Rake::Task['snowpacker:clobber'].invoke
end
