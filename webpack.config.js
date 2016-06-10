var HtmlWebpackPlugin = require('html-webpack-plugin');
// When it's ready, the webpage will use:
//
// plugins: [
//   new HtmlWebpackPlugin({
//     title: 'Whose News',
//     filename: 'index.html',
//     template: './src/views/index',
//     inject: 'head',
//     hash: true,
//     cache: true,
//     showErrors: true
//   })
// ],

var fileLoader = function(extension, name){
  if(!name) name = '[name]'
  extension = extension ? '.' + extension : ''
  return 'file?hash=sha512&digest=hex&name=' + name + '-[hash].[ext]' + extension
}

var slimToStringLoader  = {
                            test: /(\.html)?\.(slm|slim)/,
                            loaders: ["html?interpolate", "slm"]
                          },
    slimRawLoader       = {
                            test: /(\.html)?\.(slm|slim)/,
                            loaders: [fileLoader('html'), "extricate", "interpolate", "slm"]
                          },
    loaders = [
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
      fileLoader(),
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
    test: /\.json$/,
    loaders: ["json"]
  },
  {
    test: /\.yaml$/,
    loaders: ["json", "yaml"]
  },
  { test: /\.cson$/, loaders: ["file?name=[name].json", "extricate", "interpolate", "cson?file"] }
];

var resolve = {
    extensions: ["", ".webpack.js", ".web.js", ".js", '.cson', '.coffee', '.slim']
};

module.exports = [
  {
    entry: './src/chrome/manifest',
    resolve: resolve,
    module: {
      loaders: loaders.concat(slimRawLoader)
    },
    target: 'web',
    node: {
      fs: 'empty'
    },
    output: {
      path: './build/chrome',
      filename: 'manifest.js'
    },
  },
  {
    entry: './src/bookmarklet/bookmarklet',
    resolve: resolve,
    module: {
      loaders: loaders.concat(slimToStringLoader)
    },
    output: {
      path: './build/bookmarklet',
      filename: 'whosenews.js',
      sourceMapFilename: 'whosenews.js.map'
    },
    target: 'web'
  }
];
