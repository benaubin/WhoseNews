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
  slimToStringLoader
  resolve,
  loaders
} = require('./webpack.config.helpers')

gulp.task 'clean-build', ->
  gulp.src('build/*', read: false).pipe clean()

gulp.task 'clean-chrome', ->
  gulp.src('build/chrome/*', read: false).pipe clean()
  gulp.src('build/chrome.zip', read: false).pipe clean()

gulp.task 'chrome', ['clean-chrome'], ->
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

gulp.task 'bookmarklet', (callback) ->
  gulp.src ['src/bookmarklet/bookmarklet.coffee']
    .pipe named()
    .pipe gulpWebpack
      target: 'web'
      resolve: resolve
      module:
        loaders: loaders.concat slimToStringLoader
      node:
        fs: 'empty'
    .pipe gulp.dest 'build/bookmarklet'
