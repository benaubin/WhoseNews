corporations = require '../shared/corporations'

console.log corporations.brands().fromHostname location.hostname

# chrome.runtime.onMessage.addListener (message, sender, sendResponse) ->
#   try
#     if (message.title == "brand")
#       brand = Brand.fromJSON message.brand
#       window.newsBrand = brand
#       sendResponse status: "success", message: "Got Brand", brand: brand
#   catch e
#     sendResponse status: "failed", error: e
