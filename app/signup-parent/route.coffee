`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from
  'simple-auth/mixins/unauthenticated-route-mixin'`

SignupParentRoute = Ember.Route.extend UnauthenticatedRouteMixin,

  model: ->
    @store.createRecord 'parent'

`export default SignupParentRoute`
