/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports) {

	var getCurrentTabBrandInfo, i, item, len, ref, requests, toolbarAction;

	window.openUrl = function(url) {
	  var tab;
	  tab = safari.application.activeBrowserWindow.openTab();
	  return tab.url = url;
	};

	window.brandRequest = function(callback) {
	  return true;
	  console.log("got brand request");
	  return getCurrentTabBrandInfo(function(arg) {
	    var brand;
	    brand = arg.brand;
	    console.log("sending back brand.");
	    return callback(brand.toJSON());
	  });
	};

	toolbarAction = null;

	ref = safari.extension.toolbarItems;
	for (i = 0, len = ref.length; i < len; i++) {
	  item = ref[i];
	  if (item.identifier === "whosenews") {
	    toolbarAction = item;
	  }
	}

	window.toolbarAction = toolbarAction;

	console.log("Found toolbar action, ", toolbarAction, ", in ", safari.extension.toolbarItems);

	requests = {};

	safari.application.addEventListener("message", function(arg) {
	  var brand, id, message, title;
	  title = arg.title, message = arg.message;
	  console.log("Got message", title, message);
	  if (title === "brand") {
	    brand = Brand.fromJSON(message.brand);
	    console.log("Got brand", brand);
	    if (id = message != null ? message.id : void 0) {
	      requests[id](message);
	      return delete requests[id];
	    }
	  }
	}, false);

	getCurrentTabBrandInfo = function(callback) {
	  var id;
	  id = (Math.random() + Math.random()) * Date.now();
	  requests[id] = function(message) {
	    console.log("Request got brand.");
	    return callback({
	      brand: message.brand
	    });
	  };
	  safari.application.activeBrowserWindow.activeTab.page.dispatchMessage('brand-request', {
	    id: id
	  });
	  return console.log("Sent request #", id, " (", requests[id], ") to page.");
	};


/***/ }
/******/ ]);