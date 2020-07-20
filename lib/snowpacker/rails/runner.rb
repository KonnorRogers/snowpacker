# frozen_string_literal: true

module Snowpacker
  module Rails
    class Runner
      # Build for production
      def build
        snowpacker_command(env: :production, cmd: :build)
      end

      # Serve for development
      def dev
        snowpacker_command(env: :development, cmd: :dev)
      end

      private

      def snowpacker_command(*args, env: '', cmd: '')
        command = "NODE_ENV=#{env} yarn run snowpack #{cmd} #{args.flatten.join(' ')}"
        output = exec(command)
      end
    end
  end
end
