`import Ember from 'ember'`
`import StatesMixin from 'sitterfied-web/mixins/states'`
`import logger from 'sitterfied-web/services/logger'`

LOG = logger.loggerFor('address-form-component')

AddressFormComponent = Ember.Component.extend StatesMixin

`export default AddressFormComponent`
