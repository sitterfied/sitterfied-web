`import Ember from 'ember'`
`import localStorageOrCookie from
  'sitterfied-web/utils/local-storage-or-cookie'`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('application-route')

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  Ember.TargetActionSupport,

  titleToken: ->
    "#@get('env.titlePrefix')}#{@get('env.appName')}"

  title: (tokens) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      Ember.RSVP.all(tokens).then((resolvedTokens) ->
        resolve(resolvedTokens.reverse().join(' . '))
      , (error) =>
        LOG.error
          event: 'Error collecting title tokens'
          secondary: error: error
        resolve(@titleToken())
      )

  actions:
    authenticateSession: ->
      notLogin = window.location.pathname isnt '/login'
      if notLogin
        window.location.pathname = '/'
      else
        @_super()

    sessionAuthenticationSucceeded: ->
      @controllerFor('landing').closeCurrentModal()
      @_super(arguments...)
      
`export default ApplicationRoute`
