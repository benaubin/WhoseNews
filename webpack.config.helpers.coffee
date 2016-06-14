fileLoader = (extension, name = '[name]') ->
  extension = if extension then ".#{extension}" else ""
  "file?hash=sha512&digest=hex&name=#{name}-[hash].[ext]#{extension}"

module.exports =
  fileLoader: fileLoader
  slimToStringLoader:
    test: /(\.html)?\.(slm|slim)/
    loaders: ["html?interpolate", "slm"]
  loaders: [
      { test: /\.coffee$/, loader: "coffee-loader" }
      { test: /\.(coffee\.md|litcoffee)$/, loader: "coffee-loader?literate" }
      { test: /\.md$/, loaders: ["html?interpolate", "markdown"] }
      {
        test: /\.(slm|slim)/
        loaders: [fileLoader('html'), "extricate", "interpolate", "slm"]
      }
      {
        test: /\.(jpe?g|png|gif|svg)$/i
        loaders: [
          fileLoader()
          'image-webpack?bypassOnDebug&optimizationLevel=7&interlaced=false'
        ]
      }
      {
        test: /\.scss$/,
        loaders: ['style', "css", "resolve-url", "sass"]
      }
      { test: /\.css$/, loaders: ["style", "css", "resolve-url"] }
      { test: /\.json$/, loaders: ["json"] }
      { test: /\.yaml$/, loaders: ["json", "yaml"] }
      { test: /\.cson$/, loaders: ["file?name=[name].json", "extricate", "interpolate", "cson?file"] },
      { test: /\.(eot|ttf|woff2?)$/, loader: fileLoader()}
    ]
  resolve:
    extensions: [
      ""
      ".webpack.js"
      ".web.js"
      ".js"
      '.cson'
      '.coffee',
      '.slim'
      '.scss'
      'css'
    ]
