`import Ember from 'ember'`

LabelAndInputComponent = Ember.Component.extend
  classNames: ['row']
  inputType: 'text'
  labelClass: 'label text-gray_35'

  inputId: (->
    "#{@get('elementId')}-input"
  ).property('property', 'elementId')

 `export default LabelAndInputComponent`
