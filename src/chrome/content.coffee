corporations = require '../shared/corporations'

window.postMessage title: "WhoseNews-Installed", platform: "chrome", "*"

if brand = corporations.brands().fromHostname location.hostname
  message =
    title: "brand"
    brand: brand

  chrome.runtime.sendMessage message, (response) ->
    console.log "Got response", response

chrome.runtime.onMessage.addListener (message, sender, sendResponse) ->
  if message.title = "brand-request"
    brand = corporations.brands().fromHostname location.hostname
    sendResponse brand: brand
