corporations = require '../shared/corporations'

if brand = corporations.brands().fromHostname location.hostname
  message =
    title: "brand"
    brand: brand

  chrome.runtime.sendMessage message, (response) ->
    console.log "Got response", response
