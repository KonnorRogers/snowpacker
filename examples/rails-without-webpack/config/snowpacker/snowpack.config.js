const OUTPUT_PATH = process.env["SNOWPACKER_OUTPUT_PATH"]
const PORT = process.env["SNOWPACKER_PORT"]
const BUILD_DIR = process.env["SNOWPACKER_BUILD_DIR"]
const MOUNT_DIR = process.env["SNOWPACKER_MOUNT_DIR"]
const BABEL_CONFIG = process.env["SNOWPACKER_BABEL_CONFIG_FILE"]
const POSTCSS_CONFIG = process.env["SNOWPACKER_POSTCSS_CONFIG_FILE"]
const HOSTNAME = process.env["SNOWPACKER_HOSTNAME"]

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
  out: BUILD_DIR
}

const buildOptions = {
  clean: false,
  baseUrl: "/",
  minify: true,
  webModulesUrl: `${OUTPUT_PATH}/web_modules`,
  metaDir: `${OUTPUT_PATH}/__snowpack__`
}

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
]

module.exports = {
  mount,
  plugins: plugins,
  installOptions,
  devOptions,
  buildOptions
}

