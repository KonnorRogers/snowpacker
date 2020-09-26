import { Controller } from "stimulus";

export default class HelloWorldController extends Controller {
  initialize() {
    const helloWorldElement = document.querySelector("[data-testid='hello-world']")
    if (helloWorldElement) {
      helloWorldElement.parentNode.removeChild(helloWorldElement)
    }
    const _element = this.element
    _element.dataset.testid = "hello-world";
    _element.innerText = "Hello World from Stimulus";
    const body = document.querySelector("body");
    body.appendChild(_element);
  }
}
