`import Ember from 'ember'`

SfFormComponent = Ember.Component.extend
  classNames: ['form']
  tagName: 'form'

  submit: (event) ->
    event.preventDefault()

    @sendAction()

    return false

`export default SfFormComponent`
