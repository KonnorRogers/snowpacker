
export let code = "._stylesheets_button_module__button {\n  height: 50px;\n  width: 100px;\n}\n\n._stylesheets_button_module__greenButton {\n  background: lightgreen;\n}\n";
let json = {"button":"_stylesheets_button_module__button","greenButton":"_stylesheets_button_module__greenButton _stylesheets_button_module__button"};
export default json;

const styleEl = document.createElement("style");
const codeEl = document.createTextNode(code);
styleEl.type = 'text/css';

styleEl.appendChild(codeEl);
document.head.appendChild(styleEl);