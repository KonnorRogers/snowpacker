require 'json'

class Snowpacker::Manifest
  class << self
    attr_accessor :manifest_hash

    def parse_manifest(manifest_file = Snowpacker.config.manifest_file)
      @manifest_hash ||= JSON.parse(manifest_file)
    end

    def lookup(file_name, type)
      @manifest_hash[type][file_name]
    end
  end
end
