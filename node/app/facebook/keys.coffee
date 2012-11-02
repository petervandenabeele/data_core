common = require('../common')

application_id = "150581115072636"
application_secret = "0be700149815ac3663d4e6e479f1c26d"

privateRequestAccessToken = ->
  future = common.futures.future()
  token_url = "https://graph.facebook.com/oauth/access_token?" +
              "client_id=#{application_id}" +
              "&client_secret=#{application_secret}" +
              "&grant_type=client_credentials"
  common.utils.getPage(token_url).when((body) ->
    future.deliver(body))
  future

exports.requestAccessToken = ->
  privateRequestAccessToken()

privateAccessToken = ->
  futureAccessToken = common.futures.future()
  future = privateRequestAccessToken()
  future.when((body) ->
    access_token = body[13..200]
    console.log("access_token = " + access_token)
    futureAccessToken.deliver(access_token))
  futureAccessToken

exports.accessToken = ->
  privateAccessToken()

access_token_cache = require('./access_token_cache')

exports.setAccessToken = ->
  futureSetAccessToken = common.futures.future()
  future = privateAccessToken()
  future.when((access_token) ->
    access_token_cache.setAccessToken(access_token)
    futureSetAccessToken.deliver())
  futureSetAccessToken
