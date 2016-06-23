corporations = require '../../shared/corporations'

# Require styles
throw "Missing css" unless require './pagestyles'
# Create the holder
holder = document.createElement 'div'
# Set the inner html
holder.innerHTML = require '!!raw!extricate!interpolate?prefix=[{{&suffix=}}]!slm!./holder'
# Set the id of the container
holder.id = 'whose-news-holder'
# Append the holder to the body of the page
document.getElementsByTagName('body')[0].appendChild holder

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
    response = {title: 'brand', id, brand}
    # send response
    console.log("sending response", response)
    document.getElementById("app").contentWindow.postMessage response, '*'
  if data?.title == "open-url"
    console.log "Opening url"
    window.open data.url
  if data?.title == "close"
    document.getElementsByTagName('body')[0].removeChild holder
