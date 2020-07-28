module Snowpacker
  class Env
    ENV_PREFIX = "SNOWPACKER".freeze

    class << self
      def set_env_variables(config = Snowpacker.config)
        set_env("OUTPUT_PATH", config.output_path)
        set_env("HOSTNAME", config.hostname)
        set_env("PORT", config.port)
        set_env("BUILD_DIR", config.build_dir)
        set_env("MOUNT_DIR", config.mount_dir)
        set_env("BABEL_CONFIG_FILE", config.babel_config_file)
        set_env("POSTCSS_CONFIG_FILE", config.postcss_config_file)
      end

      private

      def set_env(env_var, value)
        ENV["#{ENV_PREFIX}_#{env_var}"] ||= value.to_s
      end
    end
  end
end
