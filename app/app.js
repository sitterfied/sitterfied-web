import Ember from 'ember';
import Resolver from 'ember/resolver';
import loadInitializers from 'ember/load-initializers';
import config from 'sitterfied-web/config/environment';

var App;

Ember.MODEL_FACTORY_INJECTIONS = true;

Ember.deprecate = (function() {
  var already_shown = [];
  return function (msg, test, opt) {
    if (test) {return false}
    if (already_shown.indexOf(msg) === -1) {
      var warning = 'DEPRECATION: ' + msg;
      if (opt && opt.url) {
        warning += ' See: ' + opt.url;
      }
      console.debug(warning);
    }
    already_shown.push(msg);
  };
})();

App = Ember.Application.extend({
  rootElement: 'body',
  modulePrefix: config.modulePrefix,
  podModulePrefix: config.podModulePrefix,
  Resolver: Resolver
});

loadInitializers(App, config.modulePrefix);

export default App;
