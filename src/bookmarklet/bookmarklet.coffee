# This is the script that is saved as a bookmark
#
# addScript('[pathToMain.coffee]'); is appended to the compiled version.

addScript = (url) ->
  el = document.createElement 'script'
  el.setAttribute 'src', url
  document.body.appendChild el
