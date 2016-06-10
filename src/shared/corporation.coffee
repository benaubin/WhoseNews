objectAssign = require 'object-assign'
assert = require 'assert'
CorporationList = require './corporationList'

ownershipTypes =
  subsidiary: 'subsidiaries',
  subsidiaries: 'subsidiary',
  division: 'divisions',
  divisions: 'division'

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
    CorporationList Object.keys(data).map (name) ->
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
    @brands = require('./brand').extractFromObject @, brands if brands
  children: ->
    (@subsidiaries || []).concat(@divisions || [])
  allChildren: ->
    @children().reduce (a, child) ->
      (a.concat child.allChildren()).concat child
    , [@]
  allBrands: ->
    @allChildren().concat(@).reduce (arr, child) ->
      arr.concat child.brands || []
    , []
  toJSON: (path = []) ->
    # If the corporation has a parent
    if @parent?
      # Pluralize the ownership type to get the property
      pluralOwnershipType = ownershipTypes[@ownershipType]
      # Get the index of this corporation and add it to the path
      path.unshift @parent[pluralOwnershipType].indexOf @
      # Put the property this belongs to on the path
      path.unshift pluralOwnershipType
      # Call the parent's toJSON, passing the path
      @parent.toJSON path
    else
      # Create a json object with everything needed to reserialize this object
      json = { @name, @data }
      # Add the path to the json object
      json.path = path if path.length
      # Return it
      json
  @fromJSON: ({name, data, path}) ->
    # Create the parent corporation
    c = new Corporation name, data
    # Follow path down to the original object
    c = c[seg] for seg in path if path
    c
