import Ember from 'ember';
import Configuration from 'simple-auth/configuration';
import setup from 'simple-auth/setup';
import isLocalStorageSupported from
  'sitterfied-web/utils/is-local-storage-supported';

/**
 * Load the global configuration for simple auth that can be
 * set at runtime to support dynamic data source changes.
 */
export default {
  name: 'simple-auth',
  after: 'simple-auth-cookie-store',
  initialize: function(registry, application) {
    var env = registry.lookup('environment:main')
    var config = {};
    var simpleAuthStore;
    var crossOriginWhitelist;

    var adapter = env.get('adapter');

    if (Ember.testing) {
      simpleAuthStore = 'simple-auth-session-store:ephemeral'
    } else if (isLocalStorageSupported()) {
      simpleAuthStore = 'simple-auth-session-store:local-storage'
    } else {
      simpleAuthStore = 'simple-auth-session-store:cookie'
    }

    if (env.get('apiOptions.host')) {
      crossOriginWhitelist = [env.get('apiOptions.host')];
    }


    config = {
	  authenticationRoute:         'landing',
      routeAfterAuthentication:    'after-login',
      routeIfAlreadyAuthenticated: 'after-login',
      authorizer:                  `authorizer:${adapter}`,
      authenticator:               `authenticator:${adapter}`,
      session:                     `session:${adapter}`,
      store:                       simpleAuthStore,
      crossOriginWhitelist:        crossOriginWhitelist,
      host:                        env.get('apiOptions.host'),
      localStorageKey:
        `${env.get('localStorageNamespace')}-simple-auth-session`
    }

    Configuration.load(registry, config);
    setup(registry, application);
  }
};
