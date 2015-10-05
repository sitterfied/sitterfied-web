`import Ember from 'ember'`

ModalController = Ember.Mixin.create
  modalModel: undefined,

  isShowingLoginModal: false,

  shouldNotSwitchModals: false,
  
  canSwitchModals: Ember.computed.not('shouldNotSwitchModals'),
  
  currentModalPropertyName: Ember.computed('currentModal', ->
    if not @get('currentModal')
      return null

    modalName = Ember.String.classify(@get('currentModal'))
    "isShowing#{modalName}Modal"
  )

  closeCurrentModal: ->
    if @get('currentModalPropertyName')
      @set(@get('currentModalPropertyName'), false)

  _showModal: (name, model=undefined) ->
    if @get('canSwitchModals')
      if @get('currentModal')
        @closeCurrentModal()
        
      if model
        @set('modalModel', model)

      @set("isShowing#{name.classify()}Modal", true)
      @set('currentModal', name)

  _showLogin: ->
    if @get('session.isAuthenticated')
      return Ember.RSVP.reject('Cannot show login when user is logged in.')
    this._showModal('login')
  
  actions:
    showLogin: ->
      @_showLogin()
    closeModal: ->
      @closeCurrentModal()

 `export default ModalController`
  
