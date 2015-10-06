`import Initializer from 'simple-auth-torii/initializer'`
`import Authenticator from 'simple-auth-torii/authenticators/torii'`

Initializer.initialize = (container, application) ->
  torii = container.lookup('service:torii')
  authenticator = Authenticator.create({ torii: torii })
  application.register(
    'simple-auth-authenticator:torii',
    authenticator,
    { instantiate: false }
  )

