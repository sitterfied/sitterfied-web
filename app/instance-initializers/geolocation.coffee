initialize = (instance) ->
  # Ensure the geolocation service is created immediately, so it can begin
  # fetching location right away.
  instance.container.lookup('service:geolocation')

GeolocationInitializer =
  name: 'geolocation'

  initialize: initialize

`export {initialize}`
`export default GeolocationInitializer`
