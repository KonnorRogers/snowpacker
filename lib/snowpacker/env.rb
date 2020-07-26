module Snowpacker
  class Env
    ENV_PREFIX = "SNOWPACKER".freeze

    class << self
      def set_env_variables
        set_env("OUTPUT_PATH", Snowpacker.config.output_path)
        set_env("HOSTNAME", Snowpacker.config.hostname)
        set_env("PORT", Snowpacker.config.port)
        set_env("BUILD_DIR", Snowpacker.config.build_dir)
        set_env("MOUNT_DIR", Snowpacker.config.mount_dir)
        set_env("BABEL_CONFIG_FILE", Snowpacker.config.babel_config_file)
        set_env("POSTCSS_CONFIG_FILE", Snowpacker.config.postcss_config_file)
      end

      private

      def set_env(env_var, value)
        ENV["#{ENV_PREFIX}_#{env_var}"] ||= value.to_s
      end
    end
  end
end
