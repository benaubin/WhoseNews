BrandsList = require './brandsList'

module.exports = (list) ->
  (->
    @brands = ->
      BrandsList @reduce(((a, corp) -> a.concat corp.allBrands()), [])
  ).call(list)
  list
