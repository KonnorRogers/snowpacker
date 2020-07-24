module Snowpacker
  class Env
    ENV_PREFIX = "SNOWPACKER".freeze

    class << self
      def set_env_variables
        set_env("OUTPUT_PATH", Snowpacker.config.output_path)
        set_env("HOSTNAME", Snowpacker.config.hostname)
        set_env("PORT", Snowpacker.config.port)
      end

      private

      def set_env(env_var, value)
        ENV["#{ENV_PREFIX}_#{env_var}"] = value.to_s
      end
    end
  end
end
