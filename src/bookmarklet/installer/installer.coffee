bookmarkletScript = require 'raw!../bookmarklet'
relPathToAbs = require './relPathToAbs'
main = require 'entry?name=whosenews.js!../src/main'
$ = require 'jquery'

$ ->
  main = window.location.origin + relPathToAbs(main)
  bookmarkletScript += "addScript('#{main}', '#{window.location.origin}');"

  $('.whose-news-bookmarklet').attr('href', 'javascript:' + bookmarkletScript)
