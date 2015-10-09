`import DS from 'ember-data'`

attr = DS.attr

Model = DS.Model.extend
  showAllErrors: false

  # Fake property to handle errors on the base object
  baseError: attr 'string', ignore: true

  modelName: (->
    @constructor.modelName
  ).property()

  routeName: (->
    @constructor.routeName()
  ).property()

  templateName: (->
    @constructor.templateName()
  ).property()

  cssClass: (->
    @constructor.cssClass()
  ).property()

  # Public: override rollback to clear state of showing all errors
  rollback: ->
    @set 'showAllErrors', false
    @_super arguments...

Model.reopenClass
  typeKeyFromToString: ->
    @_typeKeyFromToString or= @toString().split(':')[1].camelize()

  routeName: -> @typeKeyFromToString().dasherize()
  templateName: -> @typeKeyFromToString().dasherize()
  cssClass: -> @typeKeyFromToString().dasherize()

  loadAll: (store) ->
    @all.forEach (rawObject) =>
      store.push @typeKeyFromToString(), rawObject

`export default Model`
