# Spec

When adding support for a platform to Whose News, it's important that it
has similar functionality in order to create a constant user experience,
maximize code reuse, and minimize bugs that could be hard to track down.

## Whose News Branding

Let's go over branding. Yeah. The thing where I tell you how to write a series
of 10 or so characters or how to use an image. Although seriously, it's pretty
important to have a consistent user experience.

### Name

When you type Whose News, please use one of these options (in order
of preference).

1. Type Whose News with capitals and a space.
2. Can't use a space? Then type WhoseNews without a space (and capitals).
3. Can't use a beginning capital? Then type whoseNews with camel case.
4. Can't use 9 characters? Then type WN & make sure Whose News is inferred from
   context. If possible, link to the homepage of Whose News every time this
   acronym is used.

## Dictionary

Here are some words/phrases that might be referred to:

### Currently Active Page

The active page the user is looking at, to be determined in any of the following ways, in order of preference:

- The currently selected tab in the currently selected window.
- The window Whose News was run on

## Implementation: Web Platform
A Whose News web platform at minimum should do the following:

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

##### Brand Request (sent from sandboxed frame)

A brand request message is used for the sandboxed frame to have access to the brand from the parent document's url, **without** access to the parent document. Brand requests are sent from the sandboxed frame to the parent window.

###### Data:

| attribute | type   | description                                 | example   |
|:---------:|:------:|---------------------------------------------|:---------:|
|`title`    | string | Title of the message, always `"brand-request"` | `"brand-request"` |
|`id`       | string | A unique id for the message                 | see above |

###### Expected Action:

When the parent window receives a brand request, it should asynchronously get the brand from the currently active page, or the url the user entered, and return a brand message.

##### Brand (sent from parent window)

A brand message is used to send the brand from the parent window to the sandboxed frame, used especially in response to a brand request.

If this message is a response to a brand-request, the message should contain an id. The id must match the the brand-request's id.

Messages include:

###### Data:

| attribute | type   | description                                 | example   |
|:---------:|:------:|---------------------------------------------|:---------:|
|`title`    | string | Title of the message, always `"brand"`      | `"brand"` |
|`id`|string|`id` of the message this is in response to (optional) | see above |
|`brand`    | object | A json serialized brand.             | `brand.toJSON()` |

##### Open URL (sent from sandboxed frame)

A brand request message is used for the sandboxed frame to have access to the brand from the parent document's url, **without** access to the parent document. Brand requests are sent from the sandboxed frame to the parent window.

###### Data:

| attribute | type   | description                                 | example   |
|:---------:|:------:|---------------------------------------------|:---------:|
|`title`    | string | Title of the message, always `"open-url"` | `"open-url"`|
|`url` | string | A url of the page to open | `"http://bensites.com/WhoseNews"`|

###### Expected Action:

When the parent window receives an open-url message, it should immediately open the url given in a new tab.
