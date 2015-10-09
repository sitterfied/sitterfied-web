`import Ember from 'ember'`

InlineErrorsComponent = Ember.Component.extend
  showImmediately: false
  hasFocusedOut: false
  classNameBindings: ['statusClass']
  model: Ember.computed.alias 'parentView.model'

  shouldShowErrors: (->
    @get('isInvalid') and
    (
      @get('hasFocusedOut') or
      @get('showImmediately') or
      @get('model.showAllErrors')
    )
  ).property('isInvalid', 'hasFocusedOut', 'showImmediately',
    'model.showAllErrors')

  init: ->
    @_super()

    # Whenever the model is saved, we reset the focus state of any inputs
    # that depended on it.
    @get('model')?.on?('didUpdate', =>
      @set('hasFocusedOut', false)
    )

    Ember.defineProperty(this, 'errors',
      Ember.computed("model.errors.#{@get('property')}", ->
        errors = @get('model.errors')
        # Work around bug that makes model.errors.propertyName not return
        # server-side errors when this property also has client-side errors.
        if errors?.errorsFor?(@get('property'))?.length
          errors.errorsFor(@get('property'))
        else
          @get("model.errors.#{@get('property')}")
      )
    )

  isInvalid: (->
    @get('errors.length') > 0
  ).property('errors.length')

  statusClass: (->
    if @get('shouldShowErrors') then 'has-error'
  ).property('shouldShowErrors')

  removeListeners: (->
    @get('model')?.off?('didUpdate')
  ).on('willDestroyElement')

  focusOut: ->
    @set('hasFocusedOut', true)

`export default InlineErrorsComponent`
