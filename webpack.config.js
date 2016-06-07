var HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: './src/javascripts/app.coffee',
  plugins: [
    new HtmlWebpackPlugin({
      title: 'Whose News',
      filename: 'index.html',
      template: './src/views/index.slim',
      inject: 'head',
      hash: true,
      cache: true,
      showErrors: true
    })
  ],
  module: {
    loaders: [
      {
        test: /(\.html)?\.(slm|slim)/,
        loaders: ["html?interpolate", "slm"]
      },
      {
        test: /\.coffee$/,
        loader: "coffee-loader"
      },
      {
        test: /\.(coffee\.md|litcoffee)$/,
        loader: "coffee-loader?literate"
      },
      {
        test: /\.md$/,
        loaders: ["html?interpolate", "markdown"]
      },
      {
        test: /\.(jpe?g|png|gif|svg)$/i,
        loaders: [
          'file?hash=sha512&digest=hex&name=[hash].[ext]',
          'image-webpack?bypassOnDebug&optimizationLevel=7&interlaced=false'
        ]
      },
      {
        test: /\.s(a|c)ss$/,
        loaders: ["style", "css", "resolve-url", "sass"]
      },
      {
        test: /\.css$/,
        loaders: ["style", "css", "resolve-url"]
      },
      {
        test: /\.json&/,
        loaders: ["json"]
      },
      {
        text: /\.yaml/,
        loaders: ["json", "yaml"]
      }
    ]
  },
  output: {
    path: './build',
    filename: 'app.js',
    sourceMapFilename: 'app.js.map'
  },
  node: {
    fs: 'empty'
  }
};
