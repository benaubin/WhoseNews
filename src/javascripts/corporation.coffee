objectAssign = require 'object-assign'
Brand = require './brand.coffee'
assert = require 'assert'

module.exports = class Corporation
  # data comes like this:
  #   shortName: Name shortened to 4 charactors or less, only if recognizable, if not defined defaults to a level higher in the higharchy.
  #   type: Public, Private
  #   commercial: boolean of if the corp is commercial
  #   description: >
  #     Long description taken from their website
  #   headquarters: City, State
  #   wikipedia: Wiki Link
  #   url: Link to their website
  #   subsidiaries: A list of corporations that are subsidiaries of this one
  #   divisions: A list of corporations that are subsidiaries of this one
  #   brands: A list of brands the corporation owns
  @extractFromObject: (data, parent, type) ->
    Object.keys(data).map (name) ->
      corpData = data[name]
      new Corporation name, corpData, parent, type
  constructor: (@name, @data, @parent, @ownershipType) ->
    {
      @shortName,
      @type,
      @commercial,
      @description,
      @headquarters,
      @wikipedia,
      @url,
      subsidiaries,
      divisions,
      brands
    } = objectAssign(objectAssign({}, (@parent && @parent.data || {})), @data)
    assert @ownershipType, "ownershipType must be given with parent" if @parent
    @subsidiaries = Corporation.extractFromObject subsidiaries, @, "subsidiary" if subsidiaries
    @divisions = Corporation.extractFromObject divisions, @, "division" if divisions
    @brands = Brand.extractFromObject @, brands if brands
