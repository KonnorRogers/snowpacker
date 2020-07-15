# frozen_string_literal: true

module Parcel
  module Rails
    class Runner
      def self.from_command_line(args)
        return from_config if args.empty?
        new(args)
      end

      def self.from_config
        to_args(::Rails.application.config.parcel)
      end

      def self.to_args(config)
        new([*config.entry_points, '-d', config.destination])
      end

      def initialize(args)
        @args = args
      end

      def compile
        parcel_commmand(:build)
      end

      def serve
        parcel_commmand
      end

      private

      def parcel_commmand(cmd = '')
        command = "yarn run parcel #{cmd} #{@args.join(' ')}"
        output = exec(command)
      end
    end
  end
end
