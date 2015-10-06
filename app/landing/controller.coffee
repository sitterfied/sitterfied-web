`import Ember from 'ember'`
`import ModalController from 'sitterfied-web/mixins/modal-controller'`
`import LoginControllerMixin from 'simple-auth/mixins/login-controller-mixin'`

LandingController = Ember.Controller.extend ModalController,
  LoginControllerMixin,
  
  appName: 'Sitterfied'
  authenticator: 'authenticator:torii'

`export default LandingController`
