`import Ember from 'ember'`

initialize = (instance) ->
  adapter = instance.container.lookup('service:store').adapterFor('application')
  if Ember.typeOf(adapter.registerAnonymousSession) is 'function'
    adapter.registerAnonymousSession()

RegisterSessionInitializer =
  name: 'register-session'
  initialize: initialize

`export {initialize}`
`export default RegisterSessionInitializer`
