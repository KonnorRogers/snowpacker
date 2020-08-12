module Snowpacker
  module YarnPackages
    def self.all_packages
      [
        snowpack_packages,
        postcss_packages,
        babel_packages,
        rollup_packages,
        misc_packages
      ].flatten
    end

    def self.snowpack_packages
      # @snowpack/babel-plugin-package-import
      %w[
        snowpack
        @snowpack/plugin-babel
      ]
    end

    def self.postcss_packages
      %w[
        postcss
        postcss-cli
        postcss-import
        postcss-flexbugs-fixes
        postcss-preset-env
      ]
    end

    def self.rollup_packages
      %w[
        @rollup/plugin-dynamic-import-vars
      ]
    end

    def self.misc_packages
      %w[
        core-js@3
      ]
    end

    def self.babel_packages
      %w[
        @babel/core
        @babel/cli
        @babel/preset-env
        @babel/plugin-transform-runtime
        babel-plugin-macros
        @babel/preset-env
        babel-plugin-macros
        @babel/plugin-syntax-dynamic-import
        babel-plugin-dynamic-import-node
        @babel/plugin-transform-destructuring
        @babel/plugin-proposal-class-properties
        @babel/plugin-proposal-object-rest-spread
        @babel/plugin-transform-runtime
        @babel/plugin-transform-regenerator
      ]
    end
  end
end
