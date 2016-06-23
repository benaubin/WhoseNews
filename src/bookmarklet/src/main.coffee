corporations = require '../../shared/corporations'
popupPath = require '../../shared/views/popup/index'

# Set the body to a local variable
body = document.getElementsByTagName('body')[0]
# Set the script tag of Whose News to a local variable
scriptTag = document.getElementById("whose-news-script")

if h = document.getElementById 'whose-news-holder'
  body.removeChild h

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

appFrame.src = scriptTag.getAttribute('data-origin') + '/' + popupPath

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
  if data?.title == "close"
    document.getElementsByTagName('body')[0].removeChild holder
