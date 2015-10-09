`import ApplicationSerializer from 'sitterfied-web/application/serializer'`

ModelSerializer = ApplicationSerializer.extend
  attrs:
    baseError: serialize: false

`export default ModelSerializer`
