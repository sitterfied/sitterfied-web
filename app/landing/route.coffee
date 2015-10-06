`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from
  'simple-auth/mixins/unauthenticated-route-mixin'`

LandingRoute = Ember.Route.extend UnauthenticatedRouteMixin,

  actions:
    facebookSignup: ->
      console.log('signup with facebook')


`export default LandingRoute`
