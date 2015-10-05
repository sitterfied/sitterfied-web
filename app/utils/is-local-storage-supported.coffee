isLocalStorageSupported = ->
  try
    # Verify localStorage is supported and working
    window.localStorage['local-storage-test'] = 1
    return true
  catch error
    return false

`export default isLocalStorageSupported`
