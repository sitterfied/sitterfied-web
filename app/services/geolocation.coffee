`import Ember from 'ember'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('geolocation-service')

GeolocationService = Ember.Object.extend Ember.Evented,
  countryCode: undefined

  fetchFromApi: (->
    adapter = @container.lookup('adapter:application')
    adapter.fetchGeolocation().then((location) =>
      return if @get('isDestroyed')

      @set('countryCode', location.country_code)

      city = location.city
      if city
        name = "#{location.city}, #{location.country_code}"
      else
        name = location.country_code

    ).catch((error) ->
      LOG.error
        event: 'Error fetching geolocation'
        secondary: error: error
    )
  ).on('init')

`export default GeolocationService`
