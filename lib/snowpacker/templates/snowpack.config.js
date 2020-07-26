const output_path = process.env["SNOWPACKER_OUTPUT_PATH"]
const port = process.env["SNOWPACKER_PORT"]
const mount_dir = process.env["SNOWPACKER_MOUNT_DIR"]
const babel_config = process.env["SNOWPACKER_BABEL_CONFIG_FILE"]
const postcss_config = process.env["SNOWPACKER_POSTCSS_CONFIG_FILE"]

// not currently supported
// const hostname = process.env["SNOWPACKER_HOSTNAME"]

const scripts = {
  "mount:web_modules": `mount web_modules --to /${output_path}`,
  "mount:__snowpack__": `mount __snowpack__ --to /${output_path}`,
  "mount:snowpacks": `mount ${mount_dir} --to /${output_path}`,
  "build:css": `postcss --config ${postcss_config}`,
  "build:js,jsx,ts,tsx": `babel --config-file ${babel_config} \
                                ${mount_dir}`
}

const installOptions = {
  NODE_ENV: true
}

const devOptions = {
  port: parseInt(port, 10),
  open: "none",
  out: "public"
}

const buildOptions = {
  clean: true,
  baseUrl: "/"
}

module.exports = {
  scripts,
  plugins: ["@snowpack/babel-plugin-package-import"],
  installOptions,
  devOptions,
  buildOptions
}

