module Snowpacker
  class Configuration
    attr_accessor :config_file

    attr_accessor :output_path
    attr_accessor :port, :hostname

    def initialize
      @output_path = "snowpacks"
      @port = "4035"
      @hostname = "localhost"
    end
  end
end
