`import Ember from 'ember'`
`import ModalControllerMixin from 'sitterfied-web/mixins/modal-controller'`

ApplicationController = Ember.Controller.extend ModalControllerMixin,
  appName: 'Sitterfied'

`export default ApplicationController`
