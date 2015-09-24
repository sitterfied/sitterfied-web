`import DS from 'ember-data'`
`import Model from './model'`
`import config from 'sitterfied-web/config/environment'`
`import EmberValidationsMixin from 'ember-validations/mixin'`

attr = DS.attr

VALIDATIONS =
  email:
    presence: true
    email:
      allowBlank: false

Account =
  Model.extend EmberValidationsMixin,

  # ----------
  # Attributes
  # ----------

  address1: attr('string')
  address2: attr('string')
  avatar: attr('string')
  cell: attr('phone')
  city: attr('string')
  date_joined: attr('date')
  email: attr('string')
  facebook_id: attr('string')
  facebook_token: attr('string')
  first_name: attr('string')
  friends: DS.hasMany 'account', async: true, inverse: null
  groups: DS.hasMany 'group', async: true, inverse: null
  id: attr('number')
  languages: DS.hasMany 'language', async: true, inverse: null
  last_name: attr('string')
  parent_or_sitter: attr('string')
  password: attr('string')
  profile: DS.belongsTo 'model', async: true, polymorphic: true, inverse: null
  reviews: DS.hasMany 'review', async: true, inverse: null
  settings: DS.belongsTo 'settings', async: true, inverse: null
  state: attr('string')
  status: attr('string')
  username: attr('string')
  zip: attr('string')

  isParent: DS.computed.equal 'parent_or_sitter', 'Parent'
  isSitter: DS.computed.equal 'parent_or_sitter', 'Sitter'

  # ---------
  # Functions
  # ---------

  deactivate: ->
    adapter = @store.adapterFor(@constructor)
    adapter.deactivate(@store, @get('modelName'), this)

  # ----------
  # Vaidations
  # ----------

  validations: VALIDATIONS

`export default Account`
