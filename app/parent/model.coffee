`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Account from 'sitterfied-web/account/model'`

attr = DS.attr

Parent = Account.extend

  # ----------
  # Attributes
  # ----------

  emergency_contact_one_name: attr 'string'
  emergency_contact_one_phone: attr 'phone'
  emergency_contact_two_name: attr 'string'
  emergency_contact_two_phone: attr 'phone'
  
`export default Parent`
