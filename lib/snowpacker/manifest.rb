require "json"

module Snowpacker
  module Manifest
    VALID_TYPES = [:js, :"js.map", :css, :"css.map"]
    class << self
      attr_accessor :manifest_hash

      def reload_manifest(manifest_file = Snowpacker.config.manifest_file)
        @manifest_hash = load_manifest(manifest_file)
      end

      def find_entrypoint(file_name, type)
        @manifest_hash[:entrypoints][file_name.to_sym][type.to_sym]
      end

      def find_file(file_name)
        @manifest_hash[file_name.to_sym]
      end

      def find_chunk(chunk_name)
        @manifest_hash[:chunks][chunk_name.to_sym][:js]
      end

      private

      # rubocop:disable Naming/MemoizedInstanceVariableName
      def load_manifest(manifest_file = Snowpacker.config.manifest_file)
        @manifest_hash ||= JSON.parse(File.read(manifest_file), symbolize_names: true)
      end
      # rubocop:enable Naming/MemoizedInstanceVariableName

      def valid_type?(type)
        return true if VALID_TYPES.include?(type)

        false
      end
    end
  end
end
