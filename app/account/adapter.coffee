`import ApplicationAdapter from 'sitterfied-web/application/adapter'`

AccountAdapter = ApplicationAdapter.extend
  attributesForKeys:
    username: 'newUsername'

  deactivate: (store, type, snapshot) ->
    data = data: is_active: false
    @ajax(@buildURL(type, snapshot.id), 'PATCH', data).then((response) ->
      payload = {}
      payload[type] = response
      store.pushPayload(type, payload)
    )

`export default AccountAdapter`
