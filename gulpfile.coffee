gulp = require 'gulp-run-seq'
gulpWebpack = require 'webpack-stream'
webpack = require 'webpack'
named = require 'vinyl-named'
rename = require 'gulp-rename'
yaml = require 'gulp-yaml'
del = require 'del'
plumber = require 'gulp-plumber'
zip = require 'gulp-vinyl-zip'
objectAssign = require 'object-assign'

{
  fileLoader,
  rawSlimLoader,
  resolve,
  loaders
} = require('./webpack.config.helpers')

webpackWatch = (config) ->
  objectAssign watch: true, config

gulp.task "default", [["clean-build", ["bookmarklet-build", "chrome-build", "homepage-build"]]]

gulp.task 'clean-build', ['clean-chrome', 'clean-bookmarklet', 'clean-homepage']
gulp.task 'clean-chrome', ->
  del [
    'build/chrome/*',
    'build/chrome.zip'
  ]
gulp.task 'clean-bookmarklet', ->
  del ['build/bookmarklet/*']
gulp.task 'clean-homepage', ->
  del ['build/homepage/*']

chromeWebpackConfig =
  target: 'web'
  resolve: resolve
  module:
    loaders: loaders
  node:
    fs: 'empty'
gulp.task 'chrome', [['clean-chrome', 'chrome-build']]
gulp.task 'chrome-build', ->
  gulp.src 'src/chrome/manifest.cson'
    .pipe plumber()
    .pipe named()
    .pipe gulpWebpack chromeWebpackConfig
    .pipe gulp.dest 'build/chrome'
    .pipe zip.dest 'build/chrome.zip'
gulp.task 'watch-chrome', ['clean-chrome'], ->
  gulp.src 'src/chrome/manifest.cson'
    .pipe plumber()
    .pipe named()
    .pipe gulpWebpack webpackWatch chromeWebpackConfig
    .pipe gulp.dest 'build/chrome'

bookmarkletWebpackConfig =
  entry: "!!file?name=[name].html!#{rawSlimLoader}!./src/bookmarklet/installer/installer.slim"
  target: 'web'
  resolve: resolve
  module:
    loaders: loaders
  node:
    fs: 'empty'
gulp.task 'bookmarklet', [['clean-bookmarklet', 'bookmarklet-build']]
gulp.task 'bookmarklet-build', (callback) ->
  gulp.src ['src/bookmarklet/installer/installer.slim']
    .pipe named()
    .pipe gulpWebpack bookmarkletWebpackConfig
    .pipe gulp.dest 'build/bookmarklet'
gulp.task 'watch-bookmarklet', ['clean-bookmarklet'], (callback) ->
  gulp.src 'src/bookmarklet/installer/installer.slim'
    .pipe plumber()
    .pipe gulpWebpack webpackWatch bookmarkletWebpackConfig
    .pipe gulp.dest 'build/bookmarklet'

homepageWebpackConfig =
  entry: "!!file?name=[name].html!#{rawSlimLoader}!./src/homepage/index.slim"
  target: 'web'
  resolve: resolve
  module:
    loaders: loaders
  node:
    fs: 'empty'
gulp.task 'homepage', [['clean-homepage', 'homepage-build']]
gulp.task 'homepage-build', (callback) ->
  gulp.src ['src/homepage/index.slim']
    .pipe named()
    .pipe plumber()
    .pipe gulpWebpack homepageWebpackConfig
    .pipe gulp.dest 'build/homepage'
gulp.task 'watch-homepage', ['clean-homepage'], (callback) ->
  gulp.src ['src/homepage/index.slim']
    .pipe named()
    .pipe plumber()
    .pipe gulpWebpack webpackWatch homepageWebpackConfig
    .pipe gulp.dest 'build/homepage'
