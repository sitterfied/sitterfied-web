/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'sitterfied-web',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
	// Enable this if you want the `window.SitterfiedWeb` global to access
    // the application
    // https://github.com/ember-cli/ember-export-application-global
    exportApplicationGlobal: false,
    // Disable ember-cli-coffeescript blueprints http://git.io/vIanh
    coffeeOptions: { blueprints: true },
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

	/**
     * Features
     */

    featureFlags: {
      // Enable analytics for page and event tracking.
      analyticsEnabled: false,
      // When true we send unauthenticated users to the root, unless they hit
      // /login
      sendUnauthenticatedToRoot: false,
      // Log verbose error messages to the console.
      enableVerboseLogging: false
	},

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
	  appName: 'Sitterfied',
	  titlePrefix: '',
	  adapter: 'sitterfied',
    }
  };

  if (environment) {
	var environmentConfig = require('./environments/' + environment);
	environmentConfig.config(ENV)
  }

  return ENV;
};
