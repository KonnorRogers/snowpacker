const fs = require('fs')
const path = require('path')

const prefix = "SNOWPACKER"
const OUTPUT_PATH = process.env[`${prefix}_OUTPUT_PATH`]
const ENTRYFILE_PATH = process.env[`${prefix}_ENTRYFILE_PATH`]
const PORT = process.env[`${prefix}_PORT`]
const BUILD_DIR = process.env[`${prefix}_BUILD_DIR`]
const MOUNT_DIR = process.env[`${prefix}_MOUNT_DIR`]
const BABEL_CONFIG = process.env[`${prefix}_BABEL_CONFIG_FILE`]
const POSTCSS_CONFIG = process.env[`${prefix}_POSTCSS_CONFIG_FILE`]
const HOSTNAME = process.env[`${prefix}_HOSTNAME`]
const HTTPS = process.env[`${prefix}_HTTPS`]

const mount = {
  [`${MOUNT_DIR}`]: `/${OUTPUT_PATH}`,
}

const installOptions = {
  NODE_ENV: true,
}

const devOptions = {
  hostname: HOSTNAME,
  port: parseInt(PORT, 10),
  open: "none",
  out: BUILD_DIR,
  secure: (HTTPS === "true")
}

const buildOptions = {
  clean: false,
  baseUrl: "/",
  minify: true,
  webModulesUrl: `${OUTPUT_PATH}/web_modules`,
  metaDir: `${OUTPUT_PATH}/__snowpack__`
}

const buildDir = path.resolve(BUILD_DIR, OUTPUT_PATH)
const entryFileDir = path.resolve(buildDir, ENTRYFILE_PATH)

const plugins = [
  [
    "@snowpack/plugin-build-script",
    {
      "cmd": `postcss --config ${POSTCSS_CONFIG}`,
      "input": [".css"],
      "output": [".css"]
    }
  ],
  [
    "@snowpack/plugin-build-script",
    {
      "cmd": `babel --config-file ${BABEL_CONFIG} --filename $FILE`,
      "input": [".js"],
      "output": [".js"]
    }
  ],
  [
    "snowpack-plugin-rollup-bundle",
    {
      extendConfig: (config) => {
        config.outputOptions.dir = path.join(entryFileDir)
        config.inputOptions.input = fs
          .readdirSync(entryFileDir)
          .map(file => path.join(entryFileDir, file))
        return config
      }
    }
  ]
]

module.exports = {
  mount,
  plugins: plugins,
  installOptions,
  devOptions,
  buildOptions
}

