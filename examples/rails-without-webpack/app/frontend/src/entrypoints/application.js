import JS from "../javascript";
import * as channels from "../channels";
import "../stylesheets/index.css";
import jsonFile from "../assets/x.json"
import logo from "../assets/logo.svg"
import SmallHouse from "../assets/small-house.png"
import "../assets/other-images/further-nested/nested-image.jpg"

import styles from "../stylesheets/button.module.css"

// Stimulus
import { parseControllerName } from "../javascript/parseControllerName"
import importAll from "import-all.macro"
import { Application } from "stimulus";

const application = Application.start();

const imports = importAll.sync("../controllers/**/*_controller.js")
for (const [fileName, importedModule] of Object.entries(imports)) {
  const controllerName = parseControllerName(fileName)
  application.register(controllerName, importedModule.default)
}

document.addEventListener("DOMContentLoaded", () => {
  const helloWorld = document.createElement("div")
  helloWorld.dataset.controller = "hello-world"
  document.body.appendChild(helloWorld)

  const img = document.createElement("img")
  img.src = logo
  img.alt = "logo"
  img.className = "logo"
  img.dataset.testid = "logo"
  img.height = 200
  img.width = 200

  const div = document.createElement("div");
  div.dataset.testid = "json-file"
  div.innerText = jsonFile.y;

  const body = document.querySelector("body")
  body.appendChild(div);
  body.appendChild(img)

  JS.append(body);
  channels.consumer.append(body);

  const smallHouse = document.createElement("img")
  smallHouse.src = SmallHouse
  smallHouse.alt = "A picture of a small house"
  smallHouse.className = "small-house"
  smallHouse.dataset.testid = "small-house"
  smallHouse.height = 200
  smallHouse.width = 200
  body.appendChild(smallHouse)

  const btn = document.createElement("button")
  btn.className = styles.greenButton
  btn.innerText = "I'm a Button"
  btn.dataset.testid = "green-button"
  body.appendChild(btn)
});
