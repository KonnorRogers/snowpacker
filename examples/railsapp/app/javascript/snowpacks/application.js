import UJS from "@rails/ujs"
import Turbolinks from "turbolinks"
import ActiveStorage from "@rails/activestorage"
import "../src/channels"

UJS.start()
Turbolinks.start()
ActiveStorage.start()

console.log("Hi from snowpacker")
