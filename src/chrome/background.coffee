Brand = require '../shared/brand'
objectAssign = require 'object-assign'

chrome.runtime.onMessage.addListener (message, sender, sendResponse) ->
  try
    if message.title == "brand"
      brand = Brand.fromJSON message.brand
      chrome.browserAction.setBadgeText {
        text: brand.badgeInfo()
        tabId: sender.tab.id
      }
      sendResponse status: "success", message: "Got Brand", brand: brand
  catch e
    throw e
    sendResponse status: "failed", error: e



title = ->
  "Whose News: #{brand || 'No news detected'}"
refreshTitle = ->
  browserAction.setTitle title()
