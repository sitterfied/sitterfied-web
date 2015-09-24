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
    coffeeOptions: { blueprints: false },
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };
  console.log(environment);


  /*
  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }
  */
  if (environment) {
	var environmentConfig = require('./environments/' + environment);
	environmentConfig.config(ENV)
  }

  return ENV;
};
