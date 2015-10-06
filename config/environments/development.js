var dataSources = require('../data-sources');

module.exports = {
  config: function(ENV) {
	var app = ENV.APP;

	app.name = 'development';
	app.titlePrefix = '𝕯 ';
	app.apiOptions = dataSources.development.apiOptions

	// Development has data-source toggle
	ENV.dataSources = dataSources;

	// Allow access to devTools
	ENV.exportApplicationGlobal = true;

	ENV['torii'] = {
	  providers: {
		'facebook-oauth2': {
		  apiKey: '509664315866025',
		  redirectUri: 'http://dev-web.sitterfied.com:8370',
		}
	  }
	};

	// ember-devtools
	// Console functions for quickly debugging the app
	ENV['ember-devtools'] = {
	  global: true,
	  enabled: true,
	};
  }
}
