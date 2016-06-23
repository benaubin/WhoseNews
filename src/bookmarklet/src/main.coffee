# Check for a previous opened copy of whose news
if window.closeWhoseNews?
  # Close it
  window.closeWhoseNews()
  # Destroy self
  document.getElementsByTagName('body')[0]
    .removeChild document.getElementById "whose-news-script"
else if window.whoseNewsLoading # If whose news is currently loading...
  # Destroy self
  document.getElementsByTagName('body')[0]
    .removeChild document.getElementById "whose-news-script"
else
  # flag that WhoseNews is loading
  window.whoseNewsLoading = true

  # Require dependencies
  corporations = require '../../shared/corporations'
  popupPath = require '../../shared/views/popup/index'

  # Set the body to a local variable
  body = document.getElementsByTagName('body')[0]
  # Set the script tag of Whose News to a local variable
  scriptTag = document.getElementById("whose-news-script")

  # Require styles
  throw "Missing css" unless require './pagestyles'
  # Create the holder
  holder = document.createElement 'div'
  # Set the inner html
  holder.innerHTML = require '!!raw!extricate!interpolate?prefix=[{{&suffix=}}]!slm!./holder'
  # Set the id of the container
  holder.id = 'whose-news-holder'
  # Append the holder to the body of the page
  body.appendChild holder

  # Set the app frame to a local variable
  appFrame = document.getElementById("whose-news-app")
  # Set the window to a local variable
  appWindow = appFrame.contentWindow
  # Set the src of the iframe to the popup
  appFrame.src = scriptTag.getAttribute('data-context') + popupPath

  # Create a function to close Whose News
  window.closeWhoseNews = ->
    delete window.closeWhoseNews
    body.removeChild scriptTag
    body.removeChild holder

  # Unflag that Whose News is loading
  window.whoseNewsLoading = false
  # Create an event listener for messages
  window.addEventListener "message", (message) ->
    # Get the data from the message
    {data} = message
    console.log "got message", data
    # On messages with the title brand-request
    if data?.title == "brand-request"
      # Get the id (and save it to a local variable)
      console.log "id", id = data.id
      # Get the brand
      brand = corporations.brands().fromHostname location.hostname
      # Create a response
      response = {title: 'brand', brand: brand.toJSON(), id}
      # Send response
      console.log("sending response", response)
      document.getElementById("whose-news-app").contentWindow.postMessage response, '*'
    if data?.title == "open-url"
      console.log "Opening url"
      window.open data.url
