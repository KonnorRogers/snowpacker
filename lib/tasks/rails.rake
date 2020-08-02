namespace :snowpacker do
  task init: :environment  do
    Rake::Task["snowpacker:init"].invoke
  end

  task build: :environment do
    Rake::Task["snowpacker:build"].invoke
  end

  task dev: :environment do
    Rake::Task["snowpacker:dev"].invoke
  end

  desc "Removes compiled assets"
  task clobber: :environment do
    build_dir = Rails.root.join(Snowpacker.config.build_dir)
    output_path = File.join(build_dir, Snowpacker.config.output_path)
    command = "rm -rf #{output_path}"
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
