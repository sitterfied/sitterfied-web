`import Ember from 'ember'`

RadioButtonComponent = Ember.Component.extend
  tagName: 'span'

  click: ->
    @set('selection', @get('value'))

  checked: (->
    @get('value') is @get('selection')
  ).property('selection', 'value')

`export default RadioButtonComponent`
