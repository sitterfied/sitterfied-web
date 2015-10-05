`import isLocalStorageSupported from
  'sitterfied-web/utils/is-local-storage-supported'`

memoryStore = {}

localStorageOrCookie =
  set: (key, value) ->
    if isLocalStorageSupported()
      localStorage[key] = value
    else if Cookies.enabled
      Cookies.set(key, value)
    else
      memoryStore[key] = value

  get: (key) ->
    if isLocalStorageSupported()
      localStorage[key]
    else if Cookies.enabled
      Cookies.get(key)
    else
      memoryStore[key]

`export default localStorageOrCookie`
