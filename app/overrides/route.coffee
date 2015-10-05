`import Ember from 'ember'`
`import AuthenticatedRouteMixin from
  'simple-auth/mixins/authenticated-route-mixin'`

Ember.Route = Ember.Route.extend AuthenticatedRouteMixin,
  useModelForGuid: true
  authenticationRequired: true

  beforeModel: (transition) ->
    if @get('authenticationRequired') and @routeName isnt 'application'
      # Call simple auth to ensure route is authenticated.
      @_super(arguments...)

  routeGuid: (->
    if @get('useModelForGuid') and @currentModel
      guid = Ember.guidFor(@currentModel)
      "#{@routeName}-#{guid}".replace('.', '-')
    else
      @routeName.replace('.', '-')
  ).property().volatile()
