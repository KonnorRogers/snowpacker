# frozen_string_literal: true

module Snowpacker
  module Rails
    class Runner
      def self.from_command_line(args)
        return from_config if args.empty?
        new(args)
      end

      def self.from_config
        to_args(::Rails.application.config.snowpacker)
      end

      def self.to_args(config)
        new([*config.entry_points, '--out', config.destination])
      end

      def initialize(args)
        @args = args
      end

      def compile
        snowpacker_command(:build)
      end

      def serve
        snowpacker_command(:dev)
      end

      private

      def snowpacker_command(cmd = '')
        command = "yarn run snowpack #{cmd} #{@args.join(' ')}"
        output = exec(command)
      end
    end
  end
end
