`import LoginComponent from 'sitterfied-web/components/login'`
`import ModalDefaultsMixin from 'sitterfied-web/mixins/modal-defaults'`
`import ModalOptionsMixin from 'sitterfied-web/mixins/modal-options'`

LoginModalComponent = LoginComponent.extend ModalDefaultsMixin,
  actions:
    switchToSignup: ->
      @sendAction('showSignup')

LoginModalComponent.reopenClass ModalOptionsMixin,
  customModalOptions:
    withParams: ['isShowingLoginModal'],
    actions:
      authenticate: 'authenticate',
      showSignup: 'showSignup'

`export default LoginModalComponent`
