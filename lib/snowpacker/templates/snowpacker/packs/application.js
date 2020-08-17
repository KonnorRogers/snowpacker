import "@rails/ujs" // Autostarts
import Turbolinks from "turbolinks"
import ActiveStorage from "@rails/activestorage"
import "../stylesheets/index.css"

Turbolinks.start()
ActiveStorage.start()

console.log("Hello from Snowpacker")
