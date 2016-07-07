BrandsList = require './brandsList'
arrayFind = require './arrayFind'

module.exports = (list) ->
  (->
    @brands = ->
      BrandsList @reduce(((a, corp) -> a.concat corp.allBrands()), [])
    @get = (name) ->
      arrayFind @, (corporation) ->
        corporation.name == name
  ).call(list)
  list
