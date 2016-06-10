yaml = require 'js-yaml'
fs = require 'fs'
Corporation = require './corporation.coffee'

data = yaml.safeLoad fs.readFileSync path.resolve(__dirname, '../data.yaml'), 'utf8'

corporationsData = data.corporations
corporations = Corporation.extractFromObject corporationsData

module.exports = corporations
