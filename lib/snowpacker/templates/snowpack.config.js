const output_path = process.env["SNOWPACKER_OUTPUT_PATH"]
const port = process.env["SNOWPACKER_PORT"]

// not currently supported
// const hostname = process.env["SNOWPACKER_HOSTNAME"]

const scripts = {
  "mount:web_modules": `mount web_modules --to /${output_path}`,
  "mount:__snowpack__": `mount __snowpack__ --to /${output_path}`,
  "mount:snowpacks": `mount app/javascript --to /${output_path}`
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

