module.exports = class Brand
  @brands: []
  # Brands are in this format:
  #     Name:
  #       description: >
  #         description from their site
  #       url: url to their site
  #       wikipedia: wikipedia link
  @extractFromObject: (parent, data) ->
    Object.keys(data).map (name) ->
      new Brand parent, name, data[name]
  constructor: (@parent, @name, @data) ->
    {@wikipedia, @url, @description} = @data
    Brand.brands.push @
