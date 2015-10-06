`import DS from 'ember-data'`
`import ApiOptionsMixin from 'sitterfied-web/mixins/api-options'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('application-adapter')

SitterfiedAdapter = DS.RESTAdapter.extend ApiOptionsMixin,
  #analytics: Ember.inject.service()
  coalesceFindRequests: true
  updateMethod: 'PATCH'
  # Caution, not part of Ember's public API
  mergedProperties: ['attributesForKey']
  attributesForKeys:
    # Note: Without this key override, the model stays in isSaving when an
    # error occurs, rather than entering an invalid state as expected. This
    # works in conjunction with the pseudo-property in App.Model.
    detail: 'baseError'

  ajaxOptions: (url, type, options) ->
    dataType = Ember.get(options, 'dataType') if options

    hash = @_super(arguments...)

    hash.dataType = dataType if dataType

    # Don't set headers if this is a list URL
    if hash?.url.indexOf(@get('listRoot')) isnt -1
      delete hash.beforeSend

    hash

  isInvalid: (xhr) ->
    error = @_super(xhr)

    if xhr and xhr.status is 400
      jsonErrors = xhr.responseJSON
      errors = {}
      if jsonErrors
        for key, value of jsonErrors
          key = @attributesForKey[key] or Ember.String.camelize(key)
          # Cloning the value is required, otherwise it disappears after it is
          # set.
          errors[key] = _.clone(Ember.makeArray(value))

      new DS.InvalidError(errors)
    else
      error

  buildURL: (type, id, snapshot) ->
    if type.charAt(type.length - 1) != 's'
      type = type + 's'
    "#{@get('host')}/#{type}/#{id}/"

  fetchGeolocation: ->
    url = "#{@get('host')}/accounts/_geolocation"
    @ajax(url, 'GET')

`export default SitterfiedAdapter`
