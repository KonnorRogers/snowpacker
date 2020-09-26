function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _unsupportedIterableToArray(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

function _iterableToArrayLimit(arr, i) { if (typeof Symbol === "undefined" || !(Symbol.iterator in Object(arr))) return; var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

import * as _controllersHello_world_controllerHello_world_controllerJs from "../controllers/hello_world_controller/hello_world_controller.js";
import JS from "../javascript/index.js";
import * as channels from "../channels/index.js";
import "../stylesheets/index.css";
import jsonFile from "../assets/x.json.proxy.js";
import logo from "../assets/logo.svg";
import SmallHouse from "../assets/small-house.png";
import "../assets/other-images/further-nested/nested-image.jpg";
import styles from "../stylesheets/button.module.css"; // Stimulus

import { parseControllerName } from "../javascript/parseControllerName.js";
import { Application } from "../web_modules/stimulus.js";
var application = Application.start();
var imports = {
  "../controllers/hello_world_controller/hello_world_controller.js": _controllersHello_world_controllerHello_world_controllerJs
};

for (var _i2 = 0, _Object$entries = Object.entries(imports); _i2 < _Object$entries.length; _i2++) {
  var _ref3 = _Object$entries[_i2];

  var _ref2 = _slicedToArray(_ref3, 2);

  var fileName = _ref2[0];
  var importedModule = _ref2[1];
  var controllerName = parseControllerName(fileName);
  application.register(controllerName, importedModule["default"]);
}

document.addEventListener("DOMContentLoaded", function () {
  var helloWorld = document.createElement("div");
  helloWorld.dataset.controller = "hello-world";
  document.body.appendChild(helloWorld);
  var img = document.createElement("img");
  img.src = logo;
  img.alt = "logo";
  img.className = "logo";
  img.dataset.testid = "logo";
  img.height = 200;
  img.width = 200;
  var div = document.createElement("div");
  div.dataset.testid = "json-file";
  div.innerText = jsonFile.y;
  var body = document.querySelector("body");
  body.appendChild(div);
  body.appendChild(img);
  JS.append(body);
  channels.consumer.append(body);
  var smallHouse = document.createElement("img");
  smallHouse.src = SmallHouse;
  smallHouse.alt = "A picture of a small house";
  smallHouse.className = "small-house";
  smallHouse.dataset.testid = "small-house";
  smallHouse.height = 200;
  smallHouse.width = 200;
  body.appendChild(smallHouse);
  var btn = document.createElement("button");
  btn.className = styles.greenButton;
  btn.innerText = "I'm a Button";
  btn.dataset.testid = "green-button";
  body.appendChild(btn);
});