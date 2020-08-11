module Snowpacker
  class Configuration
    attr_accessor :config_dir
    attr_accessor :config_file
    attr_accessor :babel_config_file
    attr_accessor :postcss_config_file
    attr_accessor :build_dir
    attr_accessor :mount_dir
    attr_accessor :output_path
    attr_accessor :port, :hostname

    # Allows dynamic definition of getters and setters
    # The setter must be the value used first.
    # @example
    #   Snowpacker.config.fake_attr # => Raises an error
    #   Snowpacker.config.fake_attr = "stuff"
    #   Snowpacker.config.fake_attr # => "stuff"
    def method_missing(method_name, *args, &block)
      # Check if the method missing an "attr=" method
      raise unless method_name.to_s.end_with?("=")

      setter = method_name
      getter = method_name.to_s.slice(0...-1).to_sym
      instance_var = "@#{getter}".to_sym

      # attr_writer
      define_singleton_method(setter) do |new_val|
        instance_variable_set(instance_var, new_val)
      end

      # attr_reader
      define_singleton_method(getter) { instance_variable_get(instance_var) }

      # Ignores all arguments but the first one
      value = args[0]

      # Actually sets the value on the instance variable
      send(setter, value)
    rescue
      # Raise error as normal, nothing to see here
      super(symbol, *args, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.end_with?("=") || super
    end
  end
end
