var dataSources = require('../data-sources')

module.exports = {
  config: function(ENV) {
	var app = ENV.APP;

	app.name = 'development';
	app.titlePrefix = '𝕯 ';

	// Development has data-source toggle
	ENV.dataSources = dataSources;

	// Allow access to devTools
	ENV.exportApplicationGlobal = true;

	// ember-devtools
	// Console functions for quickly debugging the app
	ENV['ember-devtools'] = {
	  global: true,
	  enabled: true,
	};
  }
}
