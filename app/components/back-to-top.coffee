`import Ember from 'ember'`

BackToTopComponent = Ember.Component.extend
  elementId: 'back-to-top'
  wrapperClass: 'back-to-top'
  
  didInsertElement: ->
    $element = Ember.$("##{@get('elementId')}")
    $element.hide()

    Ember.$(window).scroll ->
      if Ember.$(@).scrollTop() > 150
        $element.fadeIn()
      else
        $element.fadeOut()

  click: ->
    $element = Ember.$('html, body')
    $element.animate(scrollTop: 0, 600)
      
`export default BackToTopComponent`
