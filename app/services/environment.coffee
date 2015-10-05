`import Ember from 'ember'`
`import config from 'sitterfied-web/config/environment'`

EnvironmentService = Ember.Object.extend
  localStorageNamespace: (->
    "sf-#{@get('adapter')}"
  ).property('adapter')

  authenticator: (->
    "authenticator:#{@get('adapter')}"
  ).property('adapter')

# Export a singleton environment service
`export default EnvironmentService.create(config.APP)`
