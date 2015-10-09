/* global require, module */
var EmberApp = require('ember-cli/lib/broccoli/ember-app');
var env = process.env.EMBER_ENV;

module.exports = function(defaults) {
  var isProductionLikeEnvironment = !!env.match(/production|staging/);
  
  var app = new EmberApp(defaults, {
	minifyCSS: {
      enabled: isProductionLikeEnvironment
    },

    minifyJS: {
      enabled: isProductionLikeEnvironment
    },

    sourcemaps: {
      enabled: !isProductionLikeEnvironment,
      extensions: ['js']
    },

    wrapInEval: !isProductionLikeEnvironment,
    tests: !isProductionLikeEnvironment,
    hinting: !isProductionLikeEnvironment,

	outputPaths: {
      app: {
        css: {
          'app': '/assets/sitterfied-web.css',
          'font-faces': '/assets/font-faces.css'
        }
      }
    },

    sassOptions: {
      includePaths: [
        'node_modules/compass-mixins/lib',
        'node_modules/bootstrap-sass/assets/stylesheets'
      ]
    },
  });

  app.import('bower_components/lodash/lodash.js')
  app.import('bower_components/moment/moment.js');
  app.import('bower_components/moment-timezone/builds/moment-timezone-with-data-2010-2020.js');
  app.import('bower_components/cookies-js/src/cookies.js');
  app.import('bower_components/phoneformat/phoneformat.min.js');
  app.import('bower_components/purl/purl.js');

  app.import('bower_components/select2/select2.min.js');
  app.import('bower_components/select2/select2.css');


  // Use `app.import` to add additional libraries to the generated
  // output files.
  //
  // If you need to use different assets in different
  // environments, specify an object as the first parameter. That
  // object's keys should be the environment name and the values
  // should be the asset to use in that environment.
  //
  // If the library that you are including contains AMD or ES6
  // modules that you would like to import into your application
  // please specify an object with the list of modules as keys
  // along with the exports of each module as its value.

  return app.toTree();
};
