`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from
  'simple-auth/mixins/unauthenticated-route-mixin'`

LandingRoute = Ember.Route.extend UnauthenticatedRouteMixin,
  authenticationRequired: false

`export default LandingRoute`
