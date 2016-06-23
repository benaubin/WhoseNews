# This is the script that is saved as a bookmark
#
# addScript('[pathToMain.coffee], [originOfInstaller]'); is appended to the compiled version.

addScript = (url, origin) ->
  el = document.createElement 'script'
  el.setAttribute 'src', url
  el.id = "whose-news-script"
  el.setAttribute 'data-origin', origin
  document.body.appendChild el
