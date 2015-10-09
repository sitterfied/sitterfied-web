`import Ember from 'ember'`
`import DS from 'ember-data'`

PhoneTransform = DS.Transform.extend
  deserialize: (number) ->
    return formatLocal('US', number)

  serialize: (number) ->
    return formatE164('US', number)

`export default PhoneTransform`
