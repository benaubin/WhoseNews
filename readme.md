# WhoseNews

[![Build Status](https://travis-ci.org/penne12/WhoseNews.svg?branch=master)](https://travis-ci.org/penne12/WhoseNews)

Where does your news come from? Find out!

## Table Of Contents

- [Description](#description)
- [Progress](#progress)

-------

# Description

Ever wondered who writes your **your** news?

No - you probably answered The Verge, CNN, MSNBC, Fox, etc.

You know who writes your news, right? We'll, you might be questioning that
now that you are looking at this project, and you'd be correct to wonder.

Let's say The Verge writes a new post about Google Fiber - seems innocent,
right? Well, The Verge is owned by Vox Media, of which **Comcast** Ventures
invests in.

So - Comcast is investing in a company that is writing about Google Fiber.

You should at least know about this, right? Yeah, if you are willing to do
**a lot** of Googling (or exploration using CrunchBase).

That's a lot and not something you are going to do every time you read
an article. That multiplies the time you spend reading! You aren't going
to do that. So this extension comes in! We'll let you know who owns the
site you are reading (on The Verge? We'll let you know it's Vox), highlight
potential conflicts of interest (like a competing businesses mentioned), and
let you explore who owns what.

No one's made machine readable data for this, so we created a database. The
entire database is contained in [`data.yaml`][data]. Think something's wrong?
See something that could be made better, or something we left out? Feel free to
add it in under the MIT license. Best of all, along with our data, all of our
code is open source, so, if you have a great idea that we haven't thought of,
you can use it however you'd like under the MIT license. With all of this data,
we're excited to see what happens.


-------

# Build instructions

Just `gulp`. Builds all platforms.

-------

# Progress

- Chrome extension done.
- Bookmarklet done.
- Homepage done.
- Online Try It done.

 - Database in progress.

-------

# Contributing

WhoseNews is built with webpack:

Make sure to run `npm run build` before releasing, not just `webpack`

**To Build:** `npm run build`, runs `webpack && coffee buildyaml.coffee`
**To Debug:** `npm run debug`, runs `webpack --debug && node debug build/app.js`
**To Run:** `npm run run`, runs `webpack && node build/app.js`

-------

Based off of an idea from [Reddit][idea].


[idea]: https://www.reddit.com/r/AppIdeas/comments/4hoilq/chrome_extension_tell_me_who_owns_the_news_outlet/
[data]: http://github.com/penne12/WhoseNews/blob/master/src/data.yml.
