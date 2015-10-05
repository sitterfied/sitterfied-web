`import Base from 'simple-auth/authorizers/base'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('sitterfied-authorizer')

SitterfiedAuthorizer = Base.extend
  csrfToken: (->
    Cookies.get('csrftoken')
  ).property().volatile()

  authorize: (xhr, settings) ->
    # Ensure cookies sent cross-domain
    settings.xhrFields = withCredentials: true

    xhr.setRequestHeader('Accept', settings.accepts.json)

    # GET and HEAD requests don't need the CSRF token
    unless settings.type is 'GET' or settings.type is 'HEAD'
      if (( csrfToken = @get('csrfToken') ))
        xhr.setRequestHeader('X-CSRFToken', csrfToken)

`export default SitterfiedAuthorizer`
