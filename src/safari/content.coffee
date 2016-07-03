corporations = require '../shared/corporations'

window.postMessage title: "WhoseNews-Installed", platform: "safari", "*"

do ->
  brand = corporations.brands().fromHostname location.hostname

  sendBrand = (id) ->
    console.log("sending ", {id, brand})
    safari.self.tab.dispatchMessage "brand", {id, brand}
  sendBrand() if brand

  messageListner = ({title, message}) ->
    if title == "brand-request"
      console.log "got brand request", message
      sendBrand message.id


  safari.self.addEventListener "message", messageListner, false
