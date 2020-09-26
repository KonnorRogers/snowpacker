const consumer = {
  append: (element) => {
    const div = document.createElement("div")
    div.dataset.testid = "channels-consumer"
    div.innerText = "hello from channels"
    element.appendChild(div)
  }
}

export default consumer
