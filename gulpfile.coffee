gulp = require 'gulp'
gulpWebpack = require 'webpack-stream'
webpack = require 'webpack'
named = require 'vinyl-named'
rename = require 'gulp-rename'
yaml = require 'gulp-yaml'
clean = require 'gulp-clean'
plumber = require 'gulp-plumber'
zip = require 'gulp-vinyl-zip'

{
  fileLoader,
  rawSlimLoader,
  resolve,
  loaders
} = require('./webpack.config.helpers')

gulp.task "default", ["clean-build", "data", "bookmarklet", "chrome-build"]

gulp.task 'clean-build', ->
  gulp.src('build/*', read: false).pipe clean()

gulp.task 'clean-chrome', ->
  gulp.src('build/chrome/*', read: false).pipe clean()
  gulp.src('build/chrome.zip', read: false).pipe clean()

gulp.task 'clean-bookmarklet', ->
  gulp.src('build/bookmarklet/*', read: false).pipe clean()

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

gulp.task 'chrome', ['clean-chrome', 'chrome-build']

gulp.task 'watch-chrome', ['clean-chrome'], ->
  gulp.src 'src/chrome/manifest.cson'
    .pipe plumber()
    .pipe gulpWebpack
      target: 'web'
      watch: true
      resolve: resolve
      module:
        loaders: loaders
      devtool: 'sourcemaps'
      node:
        fs: 'empty'
    .pipe gulp.dest 'build/chrome'

gulp.task 'data-json', ->
  gulp.src('./src/data.yml')
  .pipe(yaml())
  .pipe(gulp.dest('build/data'))

gulp.task 'data-pretty-json', ->
  gulp.src('./src/data.yml')
  .pipe(yaml(spaces: 2))
  .pipe(rename(suffix: "-pretty"))
  .pipe(gulp.dest('build/data'))

gulp.task 'data', ['data-json', 'data-pretty-json']

gulp.task 'bookmarklet', ['clean-bookmarklet'], (callback) ->
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
