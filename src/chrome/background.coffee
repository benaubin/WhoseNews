Brand = require '../shared/brand'
corporations = require '../shared/corporations'
objectAssign = require 'object-assign'

brand = null

title = ->
  "Whose News: #{brand || 'No news detected'}"
refreshTitle = ->
  browserAction.setTitle title()

refreshBadge = ->
  # TODO: Use tabId
  bewrowserAction.setBadgeText title: brand?.badgeInfo, tabId: null

refreshAction = ->
  refreshTitle()
