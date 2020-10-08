import "@rails/ujs" // Autostarts
import Turbolinks from "turbolinks"
import ActiveStorage from "@rails/activestorage"
import "../stylesheets/index.css"
import "../javascript"

Turbolinks.start()
ActiveStorage.start()

console.log("Hello from Snowpacker")
