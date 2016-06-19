Brand = require '../../../brand'
popupStyles = require '../styles/popup'
ko = require 'knockout'

$ ->
  throw "Something's not right" unless Materialize
  $(".button-collapse").sideNav()

  window.addEventListener "message", (message) ->
    console.log "iframe got message", message
    {data} = message
    if data?.title == "brand"
      $('.wn-cloak').hide().removeClass ".wn-cloak"
      $('.loading').hide()
      if data?.brand
        $('.business-info').show()
        brand = Brand.fromJSON data.brand
        console.log brand
        console.log brand.parents()
        class BrandViewModel
          constructor: ->
            @brand = brand
            @parents = brand.parents()
        ko.applyBindings new BrandViewModel()
      else
        $('.none').show()
  , false
  window.parent.postMessage title: "brand-request", "*"
