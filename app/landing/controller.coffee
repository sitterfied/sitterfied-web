`import Ember from 'ember'`
`import ModalController from 'sitterfied-web/mixins/modal-controller'`

LandingController = Ember.Controller.extend ModalController,
  appName: 'Sitterfied'

  actions:
    learnMore: ->
      offset = Ember.$('#learn_more')[0].offsetTop
      height = Ember.$(document).height() - Ember.$(window).height()
      destination = if offset > height then height else offset
      Ember.$('html, body').animate(scrollTop: destination, 600, 'swing')

`export default LandingController`
