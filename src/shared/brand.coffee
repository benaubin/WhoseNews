regExpEscape = require('./regexpEscape')
arrayFind = require('./arrayFind')
Corporation = require('./corporation')
BrandsList = require('./brandsList')

module.exports = class Brand
  # Brands are in this format:
  #     Name:
  #       description: >
  #         description from their site
  #       url: url to their site
  #       wikipedia: wikipedia link
  #       domains: A list of domains the news outlet runs:
  #         - domainname.tld
  @extractFromObject: (parent, data) ->
    BrandsList Object.keys(data).map (name) ->
      new Brand parent, name, data[name]
  constructor: (@parent, @name, @data) ->
    {@wikipedia, @url, @description, @domains} = @data
    @regexp = new RegExp "(#{@domains.map((d) -> regExpEscape(d)).join "|"})$", 'i'
  ownsHostname: (hostname) ->
    hostname.match @regexp
  badgeInfo: ->
    @parent.shortName
  toJSON: ->
    # Create a json object with everything needed to reinitalize this object
    {
      parent: @parent.toJSON(),
      @name,
      @data
    }
  @fromJSON: ({parent, name, data}) ->
    # Reinitalize this object from the JSON created above
    new Brand Corporation.fromJSON(parent), name, data
