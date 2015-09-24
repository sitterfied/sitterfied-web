`import Ember from 'ember'`
`import config from 'sitterfied-web/config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'home', path: '/'

  @route 'search', path: '/search'
  
  # User Routes
  @resource 'parent', path: '/:parent_id', ->
    @route 'network'
    @route 'profile'
    @route 'reviews'
    @route 'team'

  @resource 'sitter', path: '/:sitter_id', ->
    @route 'detail'
    @route 'network'
    @route 'reviews'
    @route 'snapshot'
    @route 'profile'

  # Note: The order of these routes is crucial. Profile resolver must be last
  # so it always gets the direct top-level requests and resolves them to their
  # appropriate profile type.
  @route 'profile-resolver', path: '/:profile_resolver_id'


`export default Router`
