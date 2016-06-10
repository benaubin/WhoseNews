# From http://stackoverflow.com/questions/3561493/is-there-a-regexp-escape-function-in-javascript

module.exports = (s) ->
  s.replace /[-\/\\^$*+?.()|[\]{}]/g, '\\$&'
