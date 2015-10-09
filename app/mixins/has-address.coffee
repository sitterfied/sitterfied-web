`import Ember from 'ember'`
`import DS from 'ember-data'`

attr = DS.attr

HasAddressMixin = Ember.Mixin.create
  address1: attr 'string'
  address2: attr 'string'
  city: attr 'string'
  state: attr 'string'
  zip: attr 'string'

  stateSelect2Object: Ember.computed 'state',
    get: ->
      @_getStateSelect2Object()
    set: (key, value) ->
      return @_getStateSelect2Object() unless value
      @set('state', value.id)
      @_getStateSelect2Object()

  _getStateSelect2Object: ->
    state = @get('state')
    return unless state
    id: state, text: state

`export default HasAddressMixin`

