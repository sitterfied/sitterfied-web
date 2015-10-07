`import Ember from 'ember'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('signup-controller')

SignupController = Ember.Controller.extend
  defaultValue: 'parent'

  selectedValue: Ember.computed('defaultValue',
    get: ->
      @get('_selectedValue') or @get('defaultValue')
    set: (key, value) ->
      @set('_selectedValue', value)
      @get('_selectedValue') or @get('defaultValue')
  )
      
  actions:
    next: ->
      @transitionToRoute("signup-#{@get('selectedValue')}")

`export default SignupController`
