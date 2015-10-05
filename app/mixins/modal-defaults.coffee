`import Ember from 'ember'`

ModalDefaultsMixin = Ember.Mixin.create
  IS_LIQUID_COMPONENT: true,

   # TODO: Set to false, should be set by animation handler
  isDoneTransitioning: true,

  afterTransition: Ember.K,

  # setupEscapeListener: Ember.on('didInsertElement', ->
  #   # @_escapeKeyListener = (e) =>
  #   #   switch e.which
  #   #     when 27:
  #   #       Ember.run(() =>
  #   #         @_closeModal()
  #   #       )

  #   Ember.$(document).on('keydown', @_escapeKeyListener)
  # ),

  triggerAnimationCallbacks: Ember.on('didAnimateIn', ->
    if @get('isDestroyed')
      return

    @set('isDoneTransitioning', true)
    @afterTransition()

    Ember.run.next(() ->
      if not @get('isDestroyed')
        $input = @.$('input:first')
        if $input.length
          $input.focus()
    )
  )

  # teardownEscapeListeners: Ember.on('willDestroyElement', ->
  #   if @_escapeKeyLister
  #     Ember.$(document).off('keydown', @_escapeKeyListener)
  # ),

  _closeModal: ->
    if @get('isDoneTransitioning')
      @sendAction('closeModal')
    else
      @afterTransition = ->
        @sendAction('closeModal')

  actions:
    closeModal: ->
      @_closeModal()
    outsideClick: ->
      @_closeModal()
    escape: ->
      return false

`export default ModalDefaultsMixin`
