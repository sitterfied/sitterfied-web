`import Ember from 'ember'`
`import logger from 'sitterfied-web/services/logger'`
`import createPromise from 'sitterfied-web/utils/create-promise'`
`import StatesMixin from 'sitterfied-web/mixins/states'`

LOG = logger.loggerFor('signup-parent-controller')

SignupParentController = Ember.Controller.extend StatesMixin,

  signupIfValid: ->
    @set 'model.formErrorMessage', ''
    
    if @get 'isInvalidOrSaving'
      return @showErrorMessage()

    signupPromise = @model.save().then(() ->
      @get('session').authenticate(@get('authenticator'),
        identification: model.get('email')
        password: model.get('password')
      )
    )

    @set 'signupPromise', createPromise(signupPromise)
    signupPromise
  
  actions:
    signup: ->
      @signupIfValid()

`export default SignupParentController`
