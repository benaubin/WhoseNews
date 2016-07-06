var ExtensionPreprocessingJS = {
  run: function(arguments) {
    arguments.completionFunction({
      "location": JSON.parse(JSON.stringify(document.location))
    });
  },

  finalize: function(arguments) {
    // arguments contains the value the extension provides in [NSExtensionContext completeRequestReturningItems:completion:].
    console.log(arguments);
  }
};
