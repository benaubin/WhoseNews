bookmarkletScript = require 'raw!../bookmarklet'
relPathToAbs = require './relPathToAbs'
main = require 'entry?name=whosenews-[hash].js!../src/main'
$ = require 'jquery'

$ ->
  main = window.location.origin + relPathToAbs(main)
  bookmarkletScript += "addScript('#{main}');"

  $('.whose-news-bookmarklet').attr('href', 'javascript:' + bookmarkletScript)
