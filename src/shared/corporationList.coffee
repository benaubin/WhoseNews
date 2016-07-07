BrandsList = require './brandsList'
arrayFind = require './arrayFind'

corporationList = (list, withChildrenList=false) ->
  (->
    @withChildren = ->
      return @ if withChildrenList
      corporationList @reduce(((a, corp) -> a.concat corp.allChildren()), @), true
    @brands = ->
      BrandsList @reduce(((a, corp) -> a.concat corp.allBrands()), [])
    @get = (name) ->
      arrayFind @, (corporation) ->
        corporation.name == name
    @corporationList = true
  ).call(list)
  list

module.exports = corporationList