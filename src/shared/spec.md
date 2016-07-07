# Spec

When adding support for a platform to Whose News, it's important that it
has similar functionality in order to create a constant user experience,
maximize code reuse, and minimize bugs that could be hard to track down.

## Web Platform
A Whose News platform at minimum should do the following:

When toggled, create or add to an html document (parent document) visible to the
user with the following items:

### A sandboxed frame containing `src/shared/views/popup/index`

The sandboxed frame must not be able to access a user's browser, nor the contents
of a page that the user is visiting.

The holder should be 500 pixels tall, and 400 pixels wide. The frame should
fill the entire space and look seamless to the user (no borders, dual
scrollbars, etc). CSS styling recommended for this purpose can be found in
`src/shared/views/popup/styles/popupHolder`.

### A custom script (holder script)

The holder script will communicate with the sandboxed frame via HTML5 messages.
The response must be standardized in order for the sandboxed frame to work
consistently.

The holder script should implement the following:

#### Messages
Messages are sent as Javascript objects that could be converted into JSON and
back without losing data. This means only JSON types can be used, and no
circular dependencies are allowed, etc.

Every message sent must contain a `title` attribute, which can then be used
to interpret the intent of the message.

If a response is expected, the message should contain an id. The id can be of
any JSON-compatible type, although the id should not conflict with other
messages that might be sent to and from the content script. A pseudo-random
number added to another pseudo-random number multiplied by the current unix time
should create a number that has little chance of conflicting with another
generated number.

Example code for generating an id:

```javascript
(Math.random() + Math.random()) * Date.now()
```

Messages include:

| `title`           | description                   | `data`                   |
|-------------------|-------------------------------|--------------------------|
| `"brand-request"` | A brand request message is    | ```json                  |
|                   | used for the sandboxed frame  | {                        |
|                   | to have access to the brand   |   title: "brand-request",|
|                   | from the parent document's    |   id: see above          |
|                   | url, even without access to   | }                        |
|                   | parent document.              | ```                      |
|                   |                               |                          |
|-------------------|-------------------------------|--------------------------|


# To implement a sandboxed popup for angular, listen for messages

window.addEventListener "message", (message) ->
  {data} = message
  console.log "got message", data
  # On messages with the title brand-request
  if data?.title == "brand-request"
    # Get the id (and save it to a local variable)
    console.log "id", id = data.id
    # Get the brand
    chrome.runtime.sendMessage title: "brand-request", (data) ->
      # Set the id of the request to the id of the response
      data.id = id
      console.log("sending message", data)
      # And send back the response, example: {title: "brand", id, brand}
      document.getElementById("app").contentWindow.postMessage data, '*'
  if data?.title == "open-url"
    console.log "Opening url"
    chrome.tabs.create url: data.url
