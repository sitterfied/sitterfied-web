`import Ember from 'ember'`
`import createPromise from 'sitterfied-web/utils/create-promise'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('login-component')

LoginComponent = Ember.Component.extend
  authenticator: Ember.computed.alias('env.authenticator'),
  isLoggingIn: Ember.computed.readOnly('loginPromise.isPending'),
  shouldDisableButton: Ember.computed.or(
    'hasMissingCredentials', 'isLoggingIn'
  ),
  
  hasMissingCredentials: Ember.computed('identification', 'password',
    ->
      Ember.isEmpty(Ember.$('#id_username')[0].value) ||
        Ember.isEmpty(Ember.$('#id_password')[0].value)
  )
  
  authenticate: ->
    if @get('hasMissingCredentials')
      return

    @set('errorMessage', false)
    
    @set('identification', Ember.$.trim(Ember.$('#id_username')[0].value))
    @set('password', Ember.$('#id_password')[0].value)

    promise = @get('session').authenticate(
      @get('authenticator'),
      @getProperties('identification', 'password')
    ).then(() ->
      # TODO: Analytics event
    ).catch((error) =>
      @set('errorMessage', true)
      LOG.error
        event: error
        secondary:
          username: @get('identification')
    )

    @set('loginPromise', createPromise(promise))
    promise

  actions:
    authenticate: (->
      @authenticate()

      # Don't bubble
      false
    )

`export default LoginComponent`
