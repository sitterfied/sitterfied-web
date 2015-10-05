`import Ember from 'ember'`

SitterfiedModalComponent = Ember.Component.extend

  shouldShowClose: true

  click: (event) ->
    @sendAction('close') if event.target is @get('element')

  actions:
    close: ->
      @sendAction('close')

`export default SitterfiedModalComponent`
