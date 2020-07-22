module Snowpacker
  class Configuration
    attr_accessor :config_file
    attr_accessor :source_path, :entry_points

    attr_accessor :out
    attr_accessor :javascript, :stylesheets, :assets
  end
end
