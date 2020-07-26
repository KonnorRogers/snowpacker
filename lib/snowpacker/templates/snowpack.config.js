const output_path = process.env["SNOWPACKER_OUTPUT_PATH"]
const port = process.env["SNOWPACKER_PORT"]
const mount_dir = process.env["SNOWPACKER_MOUNT_DIR"]

// not currently supported
// const hostname = process.env["SNOWPACKER_HOSTNAME"]

const scripts = {
  "mount:web_modules": `mount web_modules --to /${output_path}`,
  "mount:__snowpack__": `mount __snowpack__ --to /${output_path}`,
  "mount:snowpacks": `mount ${mount_dir} --to /${output_path}`,
  "build:css": `postcss`
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
  plugins: ["@snowpack/plugin-babel"],
  installOptions,
  devOptions,
  buildOptions
}

