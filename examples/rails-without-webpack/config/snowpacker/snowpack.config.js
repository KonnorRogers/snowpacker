const output_path = process.env["SNOWPACKER_OUTPUT_PATH"]
const port = process.env["SNOWPACKER_PORT"]
const build_dir = process.env["SNOWPACKER_BUILD_DIR"]
const mount_dir = process.env["SNOWPACKER_MOUNT_DIR"]
const babel_config = process.env["SNOWPACKER_BABEL_CONFIG_FILE"]
const postcss_config = process.env["SNOWPACKER_POSTCSS_CONFIG_FILE"]

// not currently supported
// const hostname = process.env["SNOWPACKER_HOSTNAME"]

const scripts = {
  "mount:web_modules": `mount $WEB_MODULES --to /${output_path}/web_modules`,
  "mount:snowpacks": `mount ${mount_dir} --to /${output_path}`
}

const installOptions = {
  NODE_ENV: true
}

const devOptions = {
  port: parseInt(port, 10),
  open: "none",
  out: build_dir
}

const buildOptions = {
  clean: true,
  baseUrl: "/",
  metaDir: `${output_path}/__snowpack__`
}

const plugins = [
  [
    "@snowpack/plugin-build-script",
    {
      "cmd": `postcss --config ${postcss_config}`,
      "input": [".css"],
      "output": [".css"]
    }
  ],
  [
    "@snowpack/plugin-build-script",
    {
      "cmd": `babel --config-file ${babel_config}`,
      // ${mount_dir}`,
      "input": [".js",".jsx",".ts",".tsx"],
      "output": [".js"]
    }
  ]
]

module.exports = {
  scripts,
  plugins: plugins,
  installOptions,
  devOptions,
  buildOptions
}

