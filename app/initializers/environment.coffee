`import EnvironmentService from 'sitterfied-web/services/environment'`

initialize = (registry, app) ->
  serviceFullName = 'environment:main'
  serviceName = 'env'
  
  app.register(serviceFullName, EnvironmentService,
    instantiate: false, singleton: true)
    
  ['route', 'controller', 'component',
  'model', 'adapter', 'serializer',
  'authenticator', 'service'].forEach (type) ->
    registry.injection(type, serviceName, serviceFullName)
    
  registry.injection(serviceFullName, 'application', 'application:main')
    
EnvironmentInitializer =
  name: 'environment'
  initialize: initialize

`export {initialize}`
`export default EnvironmentInitializer`
