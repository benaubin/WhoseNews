Brand = require '../shared/brand'
objectAssign = require 'object-assign'

chrome.runtime.onMessage.addListener (message, sender, sendResponse) ->
  if message.title == "brand"
    try
      brand = Brand.fromJSON message.brand
      chrome.browserAction.setBadgeText {
        text: brand.badgeInfo()
        tabId: sender.tab.id
      }
      sendResponse status: "success", message: "Got Brand", brand: brand
    catch e
      sendResponse status: "failed", error: e
      throw e
  else if message.title == 'brand-request'
    console.log "got brand request"
    getCurrentTabBrandInfo sendResponse
    return true

getCurrentTabBrandInfo = (callback) ->
  chrome.tabs.query lastFocusedWindow: true, active: true, (tabs) ->
    chrome.tabs.sendMessage tabs[0].id, title: "brand-request", (res) ->
      callback brand: res?.brand, title: "brand"



title = ->
  "Whose News: #{brand || 'No news detected'}"
refreshTitle = ->
  browserAction.setTitle title()
