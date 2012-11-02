keys = require('../../app/facebook/keys')
common = require('../../app/common')

exports.test_requestAccessToken = (test) ->
  future = keys.requestAccessToken()
  future.when((body) ->
    console.log("body = " + body)
    test.ok((body[0...13] == 'access_token='), "access_token response starts with access_token=")
    test.done())

exports.test_accessToken = (test) ->
  future = keys.accessToken()
  future.when((access_token) ->
    test.ok((access_token.length > 30), "access_token is at least 30 chars")
    test.done())

exports.test_setAccessToken = (test) ->
   future = keys.setAccessToken()
   future.when(() ->
     test.ok((common.fb_access_token.length > 30), "access_token is at least 30 chars")
     test.done())
