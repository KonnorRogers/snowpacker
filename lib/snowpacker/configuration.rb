module Snowpacker
  class Configuration
    attr_accessor :config_dir
    attr_accessor :config_file
    attr_accessor :babel_config_file
    attr_accessor :postcss_config_file
    attr_accessor :build_dir
    attr_accessor :mount_dir
    attr_accessor :output_path
    attr_accessor :port, :hostname
  end
end
