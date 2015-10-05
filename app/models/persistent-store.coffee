`import Ember from 'ember'`
`import env from 'sitterfied-web/services/environment'`
`import isLocalStorageSupported from
  'sitterfied-web/utils/is-local-storage-supported'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('persistent-store')

STORE = if isLocalStorageSupported()
  # Local storage available
  window.localStorage
else
  # Local storage unavailable, use a plain object with no persistence
  {}

PersistentStore = Ember.Object.extend
  localStorageKey: (key) ->
    return unless key
    "#{env.get('localStorageNamespace')}-#{key}"

  unknownProperty: (key) ->
    localStorageKey = @localStorageKey(key)
    json = STORE[localStorageKey]
    return if Ember.isEmpty(json)

    try
      JSON.parse(json).data
    catch error
      LOG.error(
        event: 'Error when getting from store'
        secondary: error: error, key: key
        args: [ json ]
      )
      delete STORE[localStorageKey]
      return undefined

  setUnknownProperty: (key, value) ->
    localStorageKey = @localStorageKey(key)
    if Ember.isNone(value)
      delete STORE[localStorageKey]
    else
      json = JSON.stringify(data: value)
      try
        STORE[localStorageKey] = json
      catch error
        LOG.error(
          event: 'Error when setting to store'
          secondary: error: error, key: key
          args: [ value ]
        )
    @notifyPropertyChange(key)
    value

PersistentStore.reopenClass
  clearAll: ->
    for key of STORE
      namespace = env.get('localStorageNamespace')
      namespaceRe = new RegExp("^#{namespace}")
      delete STORE[key] if namespaceRe.test(key)

`export default PersistentStore`
