`import ApplicationAdapter from 'sitterfied-web/application/adapter'`

ParentAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    "#{@get('host')}/parents"

`export default ParentAdapter`
