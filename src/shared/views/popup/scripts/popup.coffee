popupStyles = require '../styles/popup'

$ ->
  throw "Something's not right" unless Materialize
  $(".button-collapse").sideNav()
