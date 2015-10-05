`import DS from 'ember-data'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('application-serializer')

ApplicationSerializer = DS.ActiveModelSerializer.extend
  concatenatedProperties: ['unusedKeys']
  unusedKeys: [
    'username'
  ]

  extractSingle: (store, primaryType, payload, recordId, requestType) ->
    newPayload = {}
    newPayload[primaryType.modelName] = payload
    @_super(store, primaryType, newPayload, recordId, requestType)

`export default ApplicationSerializer`
