`import DS from 'ember-data'`
`import Model from 'sitterfied-web/models/model'`
`import config from 'sitterfied-web/config/environment'`
`import EmberValidationsMixin from 'ember-validations/mixin'`
`import Phone from 'sitterfied-web/transforms/phone'`
`import HasAddressMixin from 'sitterfied-web/mixins/has-address'`

attr = DS.attr
equal = Ember.computed.equal

Account =
  Model.extend EmberValidationsMixin, HasAddressMixin,

  # ----------
  # Attributes
  # ----------

  avatar: attr 'string'
  cell: attr 'phone'
  date_joined: attr 'date'
  email: attr 'string'
  facebook_id: attr 'string'
  facebook_token: attr 'string'
  first_name: attr 'string'
  friends: DS.hasMany 'account', async: true, inverse: null
#  groups: DS.hasMany 'group', async: true, inverse: null
#  languages: DS.hasMany 'language', async: true, inverse: null
  last_name: attr 'string'
  parent_or_sitter: attr 'string'
  password: attr 'string'
  passwordConfirmation: attr 'string'
#  profile: DS.belongsTo 'model', async: true, polymorphic: true, inverse: null
#  reviews: DS.hasMany 'review', async: true, inverse: null
#  settings: DS.belongsTo 'settings', async: true, inverse: null

  status: attr 'string'
  username: attr 'string'

  isParent: equal 'parent_or_sitter', 'Parent'
  isSitter: equal 'parent_or_sitter', 'Sitter'

  # ---------
  # Functions
  # ---------

  deactivate: ->
    adapter = @store.adapterFor @constructor
    adapter.deactivate @store, @get 'modelName', this

  # ----------
  # Vaidations
  # ----------

  validations:
    email:
      presence: true
      email:
        allowBlank: false
    password:
      presence: true
      length: minimum: 8
      confirmation:
        message: "This doesn't match your new password"

`export default Account`
