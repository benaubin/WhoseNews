arrayFind = require './arrayFind'

module.exports = (list) ->
  (->
    @fromHostname = (hostname) ->
      arrayFind @, (brand) -> brand.ownsHostname hostname
    @get = (name) ->
      arrayFind @, (brand) ->
        brand.name == name
  ).call(list)
  list
