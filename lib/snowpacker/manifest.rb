require "json"

module Snowpacker
  module Manifest
    class << self
      attr_accessor :manifest_hash

      def reload_manifest(manifest_file = Snowpacker.config.manifest_file)
        @manifest_hash = load_manifest(manifest_file)
      end

      def find(file_name, type)
        @manifest_hash[type][file_name]
      end

      private

      # rubocop:disable Naming/MemoizedInstanceVariableName
      def load_manifest(manifest_file = Snowpacker.config.manifest_file)
        @manifest_hash ||= JSON.parse(File.read(manifest_file))
      end
      # rubocop:enable Naming/MemoizedInstanceVariableName

      def manifest_type(type)
        case type
        when :javascript then "js"
        when :css then "css"
        else type.to_s
        end
      end
    end
  end
end
