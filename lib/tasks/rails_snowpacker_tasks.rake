require_relative "ruby_snowpacker_tasks"

# Make it run the environment task provided by rails first
Rake::Task["snowpacker:init"].enhance(:environment)
Rake::Task["snowpacker:build"].enhance(:environment)
Rake::Task["snowpacker:dev"].enhance(:environment)
Rake::Task["snowpacker:clobber"].enhance(:environment)

Rake::Task["assets:precompile"].enhance do
  Rake::Task["snowpacker:build"].invoke
end

Rake::Task["assets:clobber"].enhance do
  Rake::Task["snowpacker:clobber"].invoke
end
