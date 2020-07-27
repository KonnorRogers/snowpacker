// Webpack
// require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()
// require("channels")

// Snowpack
import "@rails/ujs" // Autostarts
import Turbolinks from "turbolinks"
import ActiveStorage from "@rails/activestorage"
// import "../channels"

Turbolinks.start()
ActiveStorage.start()

console.log("Hello from snowpacker")

