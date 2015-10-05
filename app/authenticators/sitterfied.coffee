`import Base from 'simple-auth/authenticators/base'`
`import PersistentStore from 'sitterfied-web/models/persistent-store'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('sitterfied-authenticator')

LOGIN_UNKNOWN_ERROR = 'Error logging in. Please try again.'

SitterfiedAuthenticator = Base.extend
  host: Ember.computed.alias('env.apiOptions.host')
  loginEndpoint: '/login-ajax'
  logoutEndpoint: '/api-auth/logout'
  accountEndpoint: '/accounts/_me'

  loginUrl: (->
    url = "#{@get('host')}#{@get('loginEndpoint')}"
  ).property('host', 'loginEndpoint')

  logoutUrl: (->
    url = "#{@get('host')}#{@get('logoutEndpoint')}"
  ).property('host', 'logoutEndpoint')

  accountUrl: (->
    url = "#{@get('host')}#{@get('accountEndpoint')}"
  ).property('host', 'accountEndpoint')

  # --------------
  # Public Methods
  # --------------
  
  restore: (data) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      @_makeRequest(@get('accountUrl'), 'GET').then((response) ->
        Ember.run -> resolve(accountPayload: response)
      , (xhr, status, error) => Ember.run =>
        error = xhr.responseJSON or xhr.responseText
        if error
          LOG.error
            event: 'Error restoring session from API',
            secondary: error: error

        @_rejectWithMessage(reject)
      )

  authenticate: (credentials) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      data =
        username: credentials.identification
        password: credentials.password
      @_csrfAndLogin(data).then((response) =>
        @restore().then((response) ->
          Ember.run -> resolve(response)
        , (error) ->
          reject(error)
        )
      , (xhr, status, error) -> Ember.run ->
        if (( detail = Ember.get(xhr, 'responseJSON.detail') ))
          switch detail
            when 'Username is not whitelisted.'
              message = detail
            else
              LOG.error
                event: 'Unrecognized error on login',
                secondary: error: error
        else
          message = 'Invalid login'
        reject(message)
      )

  invalidate: (data) ->
    # Clear the user's local data
    PersistentStore.clearAll()
    new Ember.RSVP.Promise (resolve, reject) =>
      @_makeRequest(@get('logoutUrl'), 'GET').then((response) ->
        Ember.run -> resolve(response)
      , (xhr, status, error) -> Ember.run ->
        message = xhr.responseJSON or xhr.responseText
        message or= 'Bad response to invalidating session'
        reject(message)
      )

   # ----------------
   # Internal Methods
   # ----------------

   # Internal: Send the user's credentials to the server to log in.
   _login: (data) ->
     @_makeRequest(@get('loginUrl'), 'POST', data)

   # Internal: Ensure the CSRF cookie is set before setting the users
   # credentials.
   _csrfAndLogin: (data) ->
     # Ensure we have a CSRF token, then POST the credentials.
     new Ember.RSVP.Promise (resolve, reject) =>
       @_makeRequest(@get('loginUrl'), 'HEAD').then((response) =>
         @_login(data).then((response) ->
           resolve(response)
         , ->
           reject(arguments...)
         )
       , ->
         reject(arguments...)
       )

   _makeRequest: (url, type, data) ->
     Ember.$.ajax
       url:        url
       type:       type
       data:       data
       xhrFields:  withCredentials:  true

   # Internal: Reject with an error message
   _rejectWithMessage: (reject) ->
     reject(LOGIN_UNKNOWN_ERROR)

`export default SitterfiedAuthenticator`
