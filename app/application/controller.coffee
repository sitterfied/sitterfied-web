`import Ember from 'ember'`
`import ModalControllerMixin from 'sitterfied-web/mixins/modal-controller'`

HIDE_FOOTER_ROUTES = [
  'landing'
]

HIDE_HEADER_ROUTES = [
  'landing'
]

ApplicationController = Ember.Controller.extend ModalControllerMixin,
  appName: 'Sitterfied'

  shouldShowFooter: (->
    currentRouteName = @get('currentRouteName')

    !HIDE_FOOTER_ROUTES.any (hideRoute) ->
      currentRouteName.indexOf(hideRoute) is 0
    ).property('currentRouteName')

  shouldShowHeader: (->
    currentRouteName = @get('currentRouteName')

    !HIDE_HEADER_ROUTES.any (hideRoute) ->
      currentRouteName.indexOf(hideRoute) is 0
    ).property('currentRouteName')

`export default ApplicationController`
