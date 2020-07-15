# frozen_string_literal: true

namespace :parcel do
  desc 'Compiles assets using parcel bundler'
  task compile: :environment do
    Parcel::Rails::Runner.from_config.compile
  end

  desc 'Compiles assets using parcel bundler'
  task serve: :environment do
    Parcel::Rails::Runner.from_config.serve
  end

  desc 'Removes compiled assets'
  task clobber: :environment do
    command = "rm -rf #{::Rails.application.config.parcel.destination}"
    logger = Logger.new(STDOUT)
    logger.info(command)
    exec(command)
  end
end

Rake::Task['assets:precompile'].enhance do
  Rake::Task['parcel:compile'].invoke
end

Rake::Task['assets:clobber'].enhance do
  Rake::Task['parcel:clobber'].invoke
end
