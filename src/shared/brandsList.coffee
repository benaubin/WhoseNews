arrayFind = require './arrayFind'

module.exports = (list) ->
  (->
    @fromHostname = (hostname) ->
      arrayFind @, (brand) -> brand.ownsHostname hostname
  ).call(list)
  list
