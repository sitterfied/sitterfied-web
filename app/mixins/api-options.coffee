`import Ember from 'ember'`
`import env from 'sitterfied-web/services/environment'`

ApiOptionsMixin = Ember.Mixin.create(env.get('apiOptions'))

`export default ApiOptionsMixin`
