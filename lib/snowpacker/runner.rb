# frozen_string_literal: true

module Snowpacker
  module Rails
    class Runner
      def initialize(args)
        @config_file = File.expand_path(::Rails.application.config.snowpacker.config_file)
      end

      # Build for production
      def build
        snowpacker_command(env: :production, cmd: :build)
      end

      # Serve for development
      def dev
        snowpacker_command(env: :development, cmd: :dev)
      end

      private

      def snowpacker_command(env: '', cmd: '')
        command = "NODE_ENV=#{env} yarn run snowpack #{cmd} --config #{@config_file}"
        exec(command)
      end
    end
  end
end
