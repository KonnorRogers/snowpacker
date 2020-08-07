// Webpack
// require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()
// require("channels")

// Snowpack https://www.skypack.dev/ for packages
import "https://cdn.skypack.dev/@rails/ujs" // Autostarts
import Turbolinks from "https://cdn.skypack.dev/turbolinks"
import ActiveStorage from "https://cdn.skypack.dev/@rails/activestorage"
// import "../channels"
import "../stylesheets/index.css"

Turbolinks.start()
ActiveStorage.start()

console.log("Hello from snowpacker")

