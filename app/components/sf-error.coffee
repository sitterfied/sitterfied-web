`import Ember from 'ember'`

SfErrorComponent = Ember.Component.extend
  classNames: ['help-block']
  tagName: 'div'

  message: (->
    # Clone array since we're going to modify it.
    errors = @get('errors')
    return unless errors
    errors = errors.compact()
    errors = errors.map (error) ->
      Ember.get(error, 'message') or error

    return if errors.length is 0
    return errors[0] if errors.length is 1

    firstError = errors.shift()
    lastError = errors.pop()

    # Lowercase remaining errors and put the first error at the front again.
    errors = errors.invoke('toLowerCase')
    errors.unshiftObject(firstError)

    "#{errors.join(', ')} and #{lastError.toLowerCase()}"
  ).property('errors.[]')

`export default SfErrorComponent`
