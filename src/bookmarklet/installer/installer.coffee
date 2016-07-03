bookmarkletScript = require 'raw!../bookmarklet'
relPathToAbs = require './relPathToAbs'
main = require 'entry?name=whosenews.js!../src/main'
$ = require 'jquery'

throw "styles missing" unless require './installer.scss'

$ ->
  main = window.location.origin + relPathToAbs(main)
  context = window.location.origin + relPathToAbs('')
  bookmarkletScript += "addScript('#{main}', '#{context}');"

  $('.whose-news-bookmarklet')
    .attr('href', 'javascript:' + bookmarkletScript)
    .on('dragend', ->
      window.parent?.postMessage title: "WhoseNews-Installed", platform: "bookmarklet", "*"
    )
    .removeClass('hide')
  $('.spinner').hide()
