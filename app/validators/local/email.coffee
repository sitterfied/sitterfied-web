`import Base from 'ember-validations/validators/base'`
`import Messages from 'ember-validations/messages'`

EmailValidator = Base.extend
  # Has only one @, at least one character before the @, before the period and
  # after it:
  emailRegexp: /^[^@]+@[^@]+\.[^@]+$/
  init: ->
    @_super()
    if @options.message is undefined
      @set 'options.message', 'Must be a valid email address'

  call: ->
    if Ember.isEmpty(@model.get(@property))
      if !@options.allowBlank
        @errors.pushObject @options.message
    else
      if !@emailRegexp.test(@model.get(@property))
        @errors.pushObject @options.message

`export default EmailValidator`
