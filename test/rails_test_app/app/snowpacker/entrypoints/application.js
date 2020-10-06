import "@rails/ujs" // Autostarts
import Turbolinks from "turbolinks"
import ActiveStorage from "@rails/activestorage"
import "../stylesheets/index.css"
import "../javascript"
import fakeAsset from "../assets/fake-asset.png"

Turbolinks.start()
ActiveStorage.start()

console.log("Hello from Snowpacker")
