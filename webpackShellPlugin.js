// From http://stackoverflow.com/a/35337516/3144928

'use strict';

var exec = require('child_process').exec;

function puts(error, stdout, stderr) {
    console.log(stdout);
}

function WebpackShellPlugin(options) {
  this.options = {
    onBuildStart: [],
    onBuildEnd: []
  };

  if(options.onBuildStart) this.options.onBuildStart = options.onBuildStart;
  if(options.onBuildEnd) this.options.onBuildEnd = options.onBuildEnd;
}

WebpackShellPlugin.prototype.apply = function(compiler) {
  var options = this.options;

  compiler.plugin("compilation", function(){
    if(options.onBuildStart.length){
        console.log("Executing pre-build scripts");
        options.onBuildStart.forEach(function(script){exec(script, puts)});
    }
  });

  compiler.plugin("emit", function(compilation, callback){
    if(options.onBuildEnd.length){
        console.log("Executing post-build scripts");
        options.onBuildEnd.forEach(function(script){exec(script, puts)});
    }
    callback();
  });
};

module.exports = WebpackShellPlugin;
