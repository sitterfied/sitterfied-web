`import SitterfiedAuthorizer from 'sitterfied-web/authorizers/sitterfied'`
`import SitterfiedAuthenticator from 'sitterfied-web/authenticators/sitterfied'`
`import Session from 'sitterfied-web/models/session'`

initialize = (registry, app) ->
  app.register 'session:sitterfied', Session
  app.register 'authenticator:sitterfied', SitterfiedAuthenticator
  app.register 'authorizer:sitterfied', SitterfiedAuthorizer
  registry.injection('adapter', 'session', 'session:sitterfied')

AuthenticationInitializer =
  name: 'authentication'
  initialize: initialize

`export {initialize}`
`export default AuthenticationInitializer`
