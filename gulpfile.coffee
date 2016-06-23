gulp = require 'gulp-run-seq'
gulpWebpack = require 'webpack-stream'
webpack = require 'webpack'
named = require 'vinyl-named'
rename = require 'gulp-rename'
yaml = require 'gulp-yaml'
del = require 'del'
plumber = require 'gulp-plumber'
zip = require 'gulp-vinyl-zip'

{
  fileLoader,
  rawSlimLoader,
  resolve,
  loaders
} = require('./webpack.config.helpers')

gulp.task "default", [["clean-build", ["bookmarklet-build", "chrome-build"]]]

gulp.task 'clean-build', ['clean-chrome', 'clean-bookmarklet', 'clean-data']
gulp.task 'clean-chrome', ->
  del [
    'build/chrome/*',
    'build/chrome.zip'
  ]
gulp.task 'clean-bookmarklet', ->
  del ['build/bookmarklet/*']
gulp.task 'clean-data', ->
  del ['build/data/*']

gulp.task 'chrome', [['clean-chrome', 'chrome-build']]
gulp.task 'chrome-build', ->
  gulp.src 'src/chrome/manifest.cson'
    .pipe plumber()
    .pipe gulpWebpack
      target: 'web'
      resolve: resolve
      module:
        loaders: loaders
      node:
        fs: 'empty'
    .pipe gulp.dest 'build/chrome'
    .pipe zip.dest 'build/chrome.zip'


gulp.task 'bookmarklet', [['clean-bookmarklet', 'bookmarklet-build']]
gulp.task 'bookmarklet-build', (callback) ->
  gulp.src ['src/bookmarklet/installer/installer.coffee']
    .pipe named()
    .pipe gulpWebpack
      entry: "!!file?name=[name].html!#{rawSlimLoader}!./src/bookmarklet/installer/installer.slim"
      target: 'web'
      resolve: resolve
      module:
        loaders: loaders
      node:
        fs: 'empty'
    .pipe gulp.dest 'build/bookmarklet'
gulp.task 'watch-bookmarklet', ['clean-bookmarklet'], (callback) ->
  gulp.src 'src/bookmarklet/installer/installer.slim'
    .pipe plumber()
    .pipe gulpWebpack
      entry: "!!file?name=[name].html!#{rawSlimLoader}!./src/bookmarklet/installer/installer.slim"
      watch: true
      target: 'web'
      resolve: resolve
      module:
        loaders: loaders
      node:
        fs: 'empty'
    .pipe gulp.dest 'build/bookmarklet'
