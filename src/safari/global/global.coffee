window.openUrl = (url) ->
  tab = safari.application.activeBrowserWindow.openTab()
  tab.url = url

window.brandRequest = (callback) ->
  return true
  console.log "got brand request"
  getCurrentTabBrandInfo ({brand}) ->
    console.log "sending back brand."
    callback brand.toJSON()

toolbarAction = null

for item in safari.extension.toolbarItems
  toolbarAction = item if item.identifier == "whosenews"

window.toolbarAction = toolbarAction

console.log "Found toolbar action, ", toolbarAction, ", in ", safari.extension.toolbarItems

requests = {}

safari.application.addEventListener "message", ({title, message}) ->
  console.log "Got message", title, message
  if title == "brand"
    brand = Brand.fromJSON message.brand
    console.log "Got brand", brand
    if id = message?.id
      requests[id] message
      delete requests[id]
, false

getCurrentTabBrandInfo = (callback) ->
  id = (Math.random() + Math.random()) * Date.now()
  requests[id] = (message) ->
    console.log "Request got brand."
    callback brand: message.brand
  safari.application.activeBrowserWindow.activeTab.page.dispatchMessage 'brand-request', { id }
  console.log "Sent request #", id, " (", requests[id], ") to page."
