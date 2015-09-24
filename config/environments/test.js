var dataSources = require('../data-sources');

module.exports = {
  config: function(ENV) {
    var app = ENV.APP;
    app.name = 'test';
    app.titlePrefix = '¡ ';
    app.adapter = 'fixtures';
    ENV.dataSources = dataSources;

    /**
     * Features
     */

    /**
     * Addons
     */

    /**
     * Ember CLI Settings
     */

    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    app.LOG_ACTIVE_GENERATION = false;
    app.LOG_VIEW_LOOKUPS = false;
    app.LOG_RESOLVER = false;

    app.rootElement = '#ember-testing';
  }
}
