data = require '../data.yaml'
Corporation = require './corporation'

corporationsData = data.corporations
corporations = Corporation.extractFromObject corporationsData

module.exports = corporations
