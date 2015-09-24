`import DS from 'ember-data'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('application-serializer')

ApplicationSerializer = DS.ActiveModelSerializer.extend
  concatenatedProperties: ['unusedKeys']
  unusedKeys: []

`export default ApplicationSerializer`
