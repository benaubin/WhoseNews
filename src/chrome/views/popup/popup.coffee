holderStyles = require "../../../shared/views/popup/styles/popupHolder"

window.addEventListener "message", (message) ->
  {data} = message
  console.log "got message", data
  if data?.title == "brand-request"
    console.log "id", id = data.id
    chrome.runtime.sendMessage title: "brand-request", (data) ->
      data.id = id
      console.log("sending message", data)
      document.getElementById("app").contentWindow.postMessage data, '*'
