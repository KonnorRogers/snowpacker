const path = require("path")

const prefix = "SNOWPACKER"
const OUTPUT_PATH = process.env[`${prefix}_OUTPUT_PATH`]
const PORT = process.env[`${prefix}_PORT`]
const BUILD_DIR = process.env[`${prefix}_BUILD_DIR`]
const MOUNT_DIR = process.env[`${prefix}_MOUNT_DIR`]
const BABEL_CONFIG = process.env[`${prefix}_BABEL_CONFIG_FILE`]
const POSTCSS_CONFIG = process.env[`${prefix}_POSTCSS_CONFIG_FILE`]
const HOSTNAME = process.env[`${prefix}_HOSTNAME`]
const HTTPS = process.env[`${prefix}_HTTPS`]

const mount = {
  [MOUNT_DIR]: `/${OUTPUT_PATH}`
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
  baseUrl: `/`,
}

const plugins = [
  [
    "@snowpack/plugin-build-script",
    {
      "cmd": `postcss --config ${POSTCSS_CONFIG}`,
      "watch": "$1 --watch",
      "input": [".css"],
      "output": [".css"]
    }
  ],
  [
    "@snowpack/plugin-build-script",
    {
      "cmd": `babel --config-file ${BABEL_CONFIG} --filename $FILE`,
      "watch": "$1 --watch",
      "input": [".js"],
      "output": [".js"]
    }
  ],
  [
    "snowpack-plugin-rollup-bundle",
    {
      entrypoints: `${BUILD_DIR}/${OUTPUT_PATH}/entrypoints/**/*.js`,
      extendConfig: (config) => {
        config.outputOptions.dir = path.join(BUILD_DIR, OUTPUT_PATH)
        return config
      }
    }
  ]
]

const proxy = {
  [OUTPUT_PATH]: "/"
}

module.exports = {
  mount,
  plugins: plugins,
  installOptions,
  devOptions,
  buildOptions,
  proxy
}

