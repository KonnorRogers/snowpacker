var js = {
  append: function append(element) {
    var div = document.createElement("div");
    div.innerText = "hello from javascript";
    div.dataset.testid = "javascript-index";
    element.appendChild(div);
  }
};
export default js;