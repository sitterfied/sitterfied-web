`import DS from 'ember-data'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('application-serializer')

ApplicationSerializer = DS.RESTSerializer.extend
  concatenatedProperties: ['unusedKeys']
  unusedKeys: [
    'username'
  ]

  extractSingle: (store, primaryType, payload, recordId, requestType) ->
    newPayload = {}
    newPayload[primaryType.modelName] = payload
    @_super(store, primaryType, newPayload, recordId, requestType)

  serializeIntoHash: (data, type, record, options) ->
    ###
    Ember Data wraps records in an object so this override removes the wrapper
    
    ###
    @_super(data, type, record, options)
    modelName = type.modelName.underscore()
    for key, value of data[modelName]
      data[key] = value
    delete data[modelName]

`export default ApplicationSerializer`
