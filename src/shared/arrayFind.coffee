# Based on the pollyfill from here: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find

polyfill = (predicate) ->
  unless @?
    throw new TypeError('arrayFind called on null or undefined')
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

if Array::find
  module.exports = (array, predicate) -> array.find predicate
else
  module.exports = (array, predicate) -> polyfill.call array, predicate
