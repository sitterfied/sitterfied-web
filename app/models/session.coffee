`import config from 'sitterfied-web/config/environment'`
`import Base from 'simple-auth/session'`

Session = Base.extend
#  analytics: Ember.inject.service()
  profile: Ember.computed.alias 'account.profile.content'
  profileName: Ember.computed.readOnly 'account.profileName'
  username: Ember.computed.readOnly 'account.username'

  account: (->
    accountPayload = @get('secure.accountPayload')
    return unless accountPayload

    # Must look up store from container because this context already has a
    # store, which is local storage.
    store = @container.lookup('service:store')

    store.pushPayload('account', account: accountPayload)
    account = store.getById('account', accountPayload.id)
    if config.featureFlags.sendErrorReports
      Raven?.setUser(
        id:     account.get('username')
        email:  account.get('email')
        name:   account.get('displayName')
      )
    @get('analytics').track('identify', account: account)
    account
  ).property('secure.accountPayload', 'secure.account')

`export default Session`
