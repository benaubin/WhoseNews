bookmarkletScript = require 'raw!../bookmarklet'
relPathToAbs = require './relPathToAbs'
main = require 'entry?name=whosenews.js!../src/main'
$ = require 'jquery'

$ ->
  main = window.location.origin + relPathToAbs(main)
  context = window.location.origin + relPathToAbs('')
  bookmarkletScript += "addScript('#{main}', '#{context}');"

  $('.whose-news-bookmarklet').attr('href', 'javascript:' + bookmarkletScript)
