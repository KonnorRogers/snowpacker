const js = {
  append: (element) => {
    const div = document.createElement("div")
    div.innerText = "hello from javascript"
    div.dataset.testid = "javascript-index"
    element.appendChild(div)
  }
}

export default js
