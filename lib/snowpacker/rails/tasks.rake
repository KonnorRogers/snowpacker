# frozen_string_literal: true

namespace :snowpacker do
  desc 'Compiles assets using snowpack bundler'
  task build: :environment do
    Snowpacker::Rails::Runner.new.build
  end

  desc 'Compiles assets using snowpack bundler'
  task dev: :environment do
    Snowpacker::Rails::Runner.new.dev
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
  Rake::Task['snowpacker:build'].invoke
end

Rake::Task['assets:clobber'].enhance do
  Rake::Task['snowpacker:clobber'].invoke
end
