env = 'test'
#env = 'production'

access_token_cache = require('./facebook/access_token_cache')
meetup_api_key_store = require('./meetup/api_key_store')

common = {
  futures:         require('futures')

  env:             env
  utils:           require('./utils')

  fb_access_token: access_token_cache.readAccessToken()
  db_fb_name:      'fb_' + env

  meetup_api_key:  meetup_api_key_store.readApiKey()
  db_meetup_name:  'meetup_' + env
}

module.exports = common
