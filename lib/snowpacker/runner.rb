# frozen_string_literal: true

# require ::Rails.root.join('config', 'initializers', 'snowpacker')

module Snowpacker
  module Rails
    class Runner
      def initialize
        @config_file = Snowpacker.configuration.config_file
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
