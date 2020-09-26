
const code = "body {\n  background: blue;\n  color: white;\n}\n\ndiv {\n  width: 50%;\n  margin: 2rem auto;\n}\n";

const styleEl = document.createElement("style");
const codeEl = document.createTextNode(code);
styleEl.type = 'text/css';

styleEl.appendChild(codeEl);
document.head.appendChild(styleEl);