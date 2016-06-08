data = require '../data.yaml'
Corporation = require './corporation.coffee'

corporationsData = data.corporations
corporations = Corporation.extractFromObject corporationsData

module.exports = corporations
