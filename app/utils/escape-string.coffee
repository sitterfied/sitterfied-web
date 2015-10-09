escapeString = (value) ->
  return '' unless value
  escapedValue = Ember.Handlebars.Utils.escapeExpression(value)
  new Ember.Handlebars.SafeString(escapedValue)

`export default escapeString`
