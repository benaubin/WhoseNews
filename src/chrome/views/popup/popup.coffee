holderStyles = require "../../../shared/views/popup/styles/popupHolder"

# To implement a sandboxed popup for angular, listen for messages

window.addEventListener "message", (message) ->
  {data} = message
  console.log "got message", data
  # On messages with the title brand-request
  if data?.title == "brand-request"
    # Get the id (and save it to a local variable)
    console.log "id", id = data.id
    # Get the brand
    chrome.runtime.sendMessage title: "brand-request", (data) ->
      # Set the id of the request to the id of the response
      data.id = id
      console.log("sending message", data)
      # And send back the response, example: {title: "brand", id, brand}
      document.getElementById("app").contentWindow.postMessage data, '*'
  if data?.title == "open-url"
    console.log "Opening url"
    chrome.tabs.create url: data.url
