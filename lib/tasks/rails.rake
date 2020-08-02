require_relative "ruby.rake"

namespace :snowpacker do
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

# Make it run the environment task provided by rails first
Rake::Task["snowpacker:init"].enhance(:environment)
Rake::Task["snowpacker:build"].enhance(:environment)
Rake::Task["snowpacker:dev"].enhance(:environment)

Rake::Task["assets:precompile"].enhance do
  Rake::Task["snowpacker:build"].invoke
end

Rake::Task["assets:clobber"].enhance do
  Rake::Task["snowpacker:clobber"].invoke
end
