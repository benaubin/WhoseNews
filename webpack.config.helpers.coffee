fileLoader = (extension, name = '[name]') ->
  extension = if extension then ".#{extension}" else ""
  "file?hash=sha512&digest=hex&name=#{name}-[hash].[ext]#{extension}"

module.exports =
  fileLoader: fileLoader
  rawSlimLoader: [
      "extricate"
      "interpolate?prefix=[{{&suffix=}}]"
      "slm"
    ].join('!')
  loaders: [
      { test: /\.coffee$/, loader: "coffee" }
      { test: /\.coffee\.ng-classify$/, loaders: ["coffee-loader", "ng-classify-loader"] }
      { test: /\.(coffee\.md|litcoffee)$/, loader: "coffee-loader?literate" }
      { test: /\.md$/, loaders: ["html?interpolate", "markdown"] }
      {
        test: /\.sli?m$/
        loaders: [fileLoader('html'), "extricate", "interpolate?prefix=[{{&suffix=}}]", "slm"]
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
      { test: /\.cson$/, loaders: ["file?name=[name].json", "extricate", "interpolate", "cson?file"] }
      { test: /\.(eot|ttf|woff2?)$/, loader: fileLoader()}
    ]
  resolve:
    extensions: [
      ""
      ".webpack.js"
      ".web.js"
      ".js"
      '.cson'
      '.coffee'
      '.coffee.ng-classify'
      '.slim'
      '.scss'
      'css'
      '.js.slim'
    ]
