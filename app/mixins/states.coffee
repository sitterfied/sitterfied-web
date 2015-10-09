`import Ember from 'ember'`
`import select2States from 'sitterfied-web/data/states'`

StatesMixin = Ember.Mixin.create

  us_states: (->
    select2States
  ).property()

  selectedState: Ember.computed 'model.state', 'model.stateSelect2Object',
    get: ->
      @get 'model.stateSelect2Object'
    set: (key, value) ->
      @set 'model.stateSelect2Object', value
      @get 'model.stateSelect2Object'

`export deffault StatesMixin`
