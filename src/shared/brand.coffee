regExpEscape = require('./regexpEscape')
arrayFind = require('./arrayFind')

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
  ownsHostname: (hostname) ->
    hostname.match @regexp
  @fromHostname: (hostname) ->
    arrayFind Brand.brands, (brand) ->
      brand.ownsHostname hostname
