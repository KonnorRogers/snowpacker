module Snowpacker
  class Configuration
    attr_accessor :config_file
    attr_accessor :source_path, :entry_points

    attr_accessor :out
    attr_accessor :javascript, :stylesheets, :assets

    def initialize
      # @config_file = ::Rails.root.join('snowpack.config.json')

      # @source_path = ::Rails.root.join('app', 'javascript')
      # @entry_points = [File.join(@source_path, 'snowpacks', 'application.js')]

      # @out = ::Rails.root.join('snowpacks')

      # @javascript = File.join(@out, 'javascript')
      # @stylesheets = File.join(@out, 'stylesheets')
      # @assets = File.join(@out, 'assets')
    end
  end
end
