api_key_store = require('../../app/meetup/api_key_store')

exports.test_readApiKey = (test) ->
  api_key = api_key_store.readApiKey()
  test.ok((typeof(api_key) == 'string'), "api_key must be a string")
  test.ok((api_key.match(/316/)), "api_key must be a string")
  test.ok((api_key.indexOf("\n") == -1), "api_key must strip the newline")
  test.done()
