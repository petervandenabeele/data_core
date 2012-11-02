utils = require('../../app/utils')

exports.test_getPage = (test) ->
  future = utils.getPage("http://localhost.be")
  future.when((body) ->
    test.ok(true, "callback is called")
    test.done())

exports.todo = (test) ->
  console.log("TODO:")
  console.log("1) pagination for large events (e.g. Rock Werchter '314446988567262')")
  test.done()
