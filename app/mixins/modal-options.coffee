`import Ember from 'ember'`

ModalOptions = Ember.Mixin.create
  defaultModalOptions:
    dismissWithEscape: false,
    dismissWithOutsideClick: false,
    actions:
      closeModal: 'closeModal'
  customModalOptons: {},
  modalOptions: () ->
    _.merge(@defaultModalOptions, @customModalOptions)

`export default ModalOptions`
