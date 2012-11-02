access_token_cache = require('../../app/facebook/access_token_cache')

exports.test_setAccessToken = (test) ->
  original = access_token_cache.readAccessToken()
  access_token_cache.setAccessToken("ABCDEF")
  force_read_back = access_token_cache.readAccessToken()
  access_token_cache.setAccessToken(original)
  test.ok((force_read_back == "ABCDEF"), "force read back access_token is equal to set")
  test.done()
