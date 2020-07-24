module Snowpacker
  class Configuration
    attr_accessor :config_file

    attr_accessor :port, :hostname

    def initialize
      @port = "4035"
      @hostname = "localhost"
    end
  end
end
