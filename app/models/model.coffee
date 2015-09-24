`import DS from 'ember-data'`

Model = DS.Model.extend
  showAllErrors: false

  # Fake property to handle errors on the base object
  baseError: DS.attr('string')

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
    @set('showAllErrors', false)
    @_super(arguments...)

`export default Model`
