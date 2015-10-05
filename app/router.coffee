`import Ember from 'ember'`
`import config from 'sitterfied-web/config/environment'`
`import
  LoginModalComponent from 'sitterfied-web/components/login-modal'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  # Landing Routes
  @route 'landing', path: '/', ->
    @modal 'login-modal', LoginModalComponent.modalOptions()

  @route 'home', path: '/home'
    
  # Onboarding Routes
  @route 'signup', path: '/signup'
  
  #@route 'search', path: '/search'
  
  # User Routes
  @route 'parent', path: '/parents/:parent_id'
#    @route 'network'
#    @route 'profile'
#    @route 'reviews'
#    @route 'team'

  # @resource 'sitter', path: '/:sitter_id', ->
  #   @route 'detail'
  #   @route 'network'
  #   @route 'reviews'
  #   @route 'snapshot'
  #   @route 'profile'

  # # Note: The order of these routes is crucial. Profile resolver must be last
  # # so it always gets the direct top-level requests and resolves them to their
  # # appropriate profile type.
  # @route 'profile-resolver', path: '/:profile_resolver_id'
  #

  # /i/ represents an internal url
  @route 'after-login', path: '/i/after-login'

`export default Router`
