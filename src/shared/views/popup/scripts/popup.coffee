Brand = require '../../../brand'
popupStyles = require '../styles/popup'
ko = require 'knockout'

$ ->
  $('.business-info').hide()
  $('.none').hide()

  throw "Something's not right" unless Materialize
  $(".button-collapse").sideNav()

  # TODO: Find a way to do this cross browser
  chrome.runtime.sendMessage title: "brand-request", (response) ->
    $('.loading').hide()
    if response?.brand
      $('.business-info').show()
      brand = Brand.fromJSON response.brand
      console.log brand
      console.log brand.parents()
      BrandViewModel = ->
        @brand = brand
        @parents = brand.parents()
      ko.applyBindings new BrandViewModel()
    else
      $('.none').show()
