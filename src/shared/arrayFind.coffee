# Based on the pollyfill from here: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find

polyfill = (predicate) ->
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

module.exports = (array, predicate) ->
  (array.find || polyfill.bind(array))(predicate)
