`import Ember from 'ember'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('home-route')
REFRESH_HOME_AFTER_MINUTES = 30

HomeRoute = Ember.Route.extend Ember.TargetActionSupport,
  useModelForGuid: false

`export default HomeRoute`
