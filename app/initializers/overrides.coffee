# Import global Ember overrides and other global
# configuration and objects.
`import 'sitterfied-web/overrides/route'`
`import 'sitterfied-web/overrides/simple-auth-torii'`

OverridesInitializer =
  name: 'overrides'
  initialize: () ->
    return # NOOP

`export default OverridesInitializer`
