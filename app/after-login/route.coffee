`import Ember from 'ember'`

# After successful login, reroute to this route
AfterLoginRoute = Ember.Route.extend
  beforeModel: ->
    @_super(arguments...)

    @replaceWith('home')

`export default AfterLoginRoute`
