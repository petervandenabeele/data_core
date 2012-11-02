request = require('request')
futures = require('futures')

exports.getPage = (someUri) ->
  future = futures.future()
  request({uri: someUri}, (error, response, body) ->
    # console.log("Fetched OK :: " + someUri)
    future.deliver(body))
  future
