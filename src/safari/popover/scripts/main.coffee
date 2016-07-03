holderStyles = require "../../../shared/views/popup/styles/popupHolder"
safari = window.safari
globalWindow = safari.extension.globalPage.contentWindow

window.addEventListener "message", (message) ->
  {data} = message
  console.log "got message", data
  # On messages with the title brand-request
  if data?.title == "brand-request"
    # Get the id (and save it to a local variable)
    console.log "id", id = data.id

    globalWindow.brandRequest (brand) ->
      message = {brand, id, title: "brand"}
      document.getElementById("app").contentWindow.postMessage message, '*'
  if data?.title == "open-url"
    console.log "Opening url"
    globalWindow.openUrl data.url
