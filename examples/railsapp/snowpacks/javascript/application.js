import UJS from "/web_modules/@rails/ujs.js";
import Turbolinks from "/web_modules/turbolinks.js";
import ActiveStorage from "/web_modules/@rails/activestorage.js";
import "../channels/index.js";
UJS.start();
Turbolinks.start();
ActiveStorage.start();