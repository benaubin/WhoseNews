regExpEscape = require('./regexpescape.coffee')

module.exports = class Brand
  @brands: []
  # Brands are in this format:
  #     Name:
  #       description: >
  #         description from their site
  #       url: url to their site
  #       wikipedia: wikipedia link
  #       domains: A list of domains the news outlet runs:
  #         - domainname.tld
  @extractFromObject: (parent, data) ->
    Object.keys(data).map (name) ->
      new Brand parent, name, data[name]
  constructor: (@parent, @name, @data) ->
    {@wikipedia, @url, @description, @domains} = @data
    @regexp = new RegExp "(#{@domains.map((d) -> regExpEscape(d)).join "|"})$", 'i'
    Brand.brands.push @
  ownsDomain: (hostname) ->
    hostname.match @regexp
  @fromDomain: (hostname) ->
    Brand.brands.find (brand) ->
      brand.ownsDomain hostname

Array::find ||= (predicate) ->
  throw new TypeError('Array.prototype.find called on null or undefined') unless @?
  if typeof predicate != 'function'
    throw new TypeError('predicate must be a function')
  list = Object @
  length = list.length >>> 0
  thisArg = arguments[1]
  value = undefined
  i = 0
  while i < length
    value = list[i]
    return value if predicate.call(thisArg, value, i, list)
    i++
